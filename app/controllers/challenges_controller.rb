class ChallengesController < ApplicationController
  before_action :authenticate_player!, except: [:index, :explore]
  before_action :authenticate_creator, only: [:confirm, :confirmed, :destroy]
  def explore
    if params[:tags].present?
      @challenges = []
      @tags = []
      params[:tags].split(',').each do |searched_tag|
        Tag.where('name LIKE ?', "%#{searched_tag.strip}%").each do |tag|
          @tags << tag
        end
      end
      @tags.each do |tags|
        tags.challenges.each do |challenge|
          @challenges << challenge
        end
      end
    else
      @challenges = Challenge.all.where(status: "open")
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    @parties = @challenge.parties
    @verifiers = @challenge.verifiers
  end

  def edit
    @challenge = Challenge.find(params[:id])
    @challenge.verifiers.build
    @challenge.parties.build
  end

  def confirm
    @challenge = Challenge.find(params[:id])
    @parties = @challenge.parties
    @verifiers = @challenge.verifiers
    @participation = Participation.new
  end

  def confirmed
    @challenge = Challenge.find(params[:id])
    if @challenge.open!
      session.delete(:new_challenge)
      redirect_to challenge_path(@challenge.id), notice: "Challenge created and open to other players!"
    end
  end

  def new
    #Hay que resolver cuando usuario pone atras no con boton back (ya que no destruye el challenge), agregar tb metodo destroy
    # if session[:new_challenge].present?
    #   parameters = session[:new_challenge]
    #   @challenge = Challenge.new(parameters)
    # else
    @challenge = Challenge.new
    # end
    @challenge.verifiers.build
    @challenge.parties.build
  end

  def create
    parameters = (challenge_params)
    saved = params[:challenge].clone
    session[:new_challenge] = saved
    session[:new_challenge].delete(:verifiers_attributes)
    session[:new_challenge].delete(:parties_attributes)
    if params[:challenge][:local].to_i == 1
      parameters[:local] = true
    else
      parameters[:local] = false
    end
    parameters[:expiration_date] = "#{params[:challenge]['expiration_date(1i)']}-#{params[:challenge]['expiration_date(2i)']}-#{params[:challenge]['expiration_date(3i)']} #{params[:challenge]['expiration_date(4i)']}:#{params[:challenge]['expiration_date(5i)']}:00 -0300"
    parameters[:closing_date] = "#{params[:challenge]['closing_date(1i)']}-#{params[:challenge]['closing_date(2i)']}-#{params[:challenge]['closing_date(3i)']} #{params[:challenge]['closing_date(4i)']}:#{params[:challenge]['closing_date(5i)']}:00 -0300"
    parameters[:creator_id] = current_player.id
    @challenge = Challenge.new(parameters)
    if @challenge.save
      redirect_to challenge_path(@challenge.id)
    else
      message = ''
      @challenge.errors.full_messages.each do |error|
        message += error.to_s
      end
      redirect_back(fallback_location: new_challenge_path, alert: message)
    end
  end

  def destroy
    #Aqui para destruir y luego crear denuevo. Recordar eliminar route update.
    @challenge = Challenge.find(params[:id])
    if @challenge.pending?
      @challenge.destroy
      redirect_to new_challenge_path, alert: 'Challenge canceled'
    end
  end

  def index
  end

  def created
    @challenges = Challenge.where(creator: current_player).order(closing_date: :desc)
    @challenges = @challenges.select { |challenge| !challenge.archived? }
  end

  def participations
    participations = current_player.participations.select { |p| p.challenge if p.challenge.open? || p.challenge.closed? }
    @challenges = participations.map { |p| p.challenge }
    @challenges.sort_by(&:expiration_date)
    @challenges.reverse!

  end

  def important
    participations = current_player.participations.select { |p| p if p.challenge.confirming_results? }
    @challenges = participations.map { |p| p.challenge }
    #habra que agregarle los casos abiertos
  end

  def archived
    participations = current_player.participations.select { |p| p.challenge if p.challenge.archived? }
    @challenges = participations.map { |p| p.challenge }
    @challenges.sort_by(&:expiration_date)
    @challenges.reverse!
  end

  private

  def challenge_params
    params.require(:challenge).permit(
      :all_tags, :title, :description, :local, :min_honor, :picture,
      :language_id, :capped, :block_size,
      verifiers_attributes: [:description],
      parties_attributes: [:description, :weight]
    )
  end

  def authenticate_creator
    redirect_to new_player_session unless
    Challenge.find(params[:id]).creator == current_player
  end
end

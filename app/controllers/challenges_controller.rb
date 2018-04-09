class ChallengesController < ApplicationController
  before_action :authenticate_player!, only: [:show, :new]
  before_action :set_challenge, only: [:show, :confirm, :confirmed, :destroy]
  load_and_authorize_resource except: [:explore, :show]
  include ChallengesHelper

  def explore
    if params[:tags].present?
      @challenges = find_by_tag(params[:tags])
    else
      @challenges = Challenge.all.where(status: "open")
    end
  end

  def show
    @parties = @challenge.parties
    @player_id = current_player.id
  end

  def confirm
    @participation = Participation.new
  end

  def confirmed
    if @challenge.open!
      session.delete(:new_challenge)
      redirect_to challenge_path(@challenge.id), notice: "Challenge created and open to other players!"
    end
  end

  def new
    @challenge = Challenge.new
    @challenge.verifiers.build
    @challenge.parties.build
  end

  def create
    @challenge = parse_challenge_data(challenge_params, params)
    if @challenge.save
      redirect_to challenge_path(@challenge.id)
    else
      message = ''
      @challenge.errors.full_messages.each do |error|
        message += (error.to_s + ' ')
      end
      redirect_back(fallback_location: new_challenge_path, alert: message)
    end
  end

  def destroy
    if @challenge.pending?
      @challenge.destroy
      redirect_to root_path, alert: 'Challenge canceled'
    end
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

  # def authenticate_creator
  #   redirect_to new_player_session unless
  #   Challenge.find(params[:id]).creator == current_player
  # end

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end
end

module ChallengesHelper

  def find_by_tag(search)
    challenges = []
    tags = []
    search.split(',').each do |searched_tag|
      Tag.where('name LIKE ?', "%#{searched_tag.strip}%").each do |tag|
        tags << tag
      end
    end
    tags.each do |tag|
      tag.challenges.each do |challenge|
        challenges << challenge
      end
    end
    challenges
  end

  def parse_challenge_data(parameters, params)
    if params[:challenge][:local].to_i == 1
      parameters[:local] = true
    else
      parameters[:local] = false
    end
    parameters[:expiration_date] = "#{params[:challenge]['expiration_date(1i)']}-#{params[:challenge]['expiration_date(2i)']}-#{params[:challenge]['expiration_date(3i)']} #{params[:challenge]['expiration_date(4i)']}:#{params[:challenge]['expiration_date(5i)']}:00 -0300"
    parameters[:closing_date] = "#{params[:challenge]['closing_date(1i)']}-#{params[:challenge]['closing_date(2i)']}-#{params[:challenge]['closing_date(3i)']} #{params[:challenge]['closing_date(4i)']}:#{params[:challenge]['closing_date(5i)']}:00 -0300"
    parameters[:creator_id] = current_player.id
    Challenge.new(parameters)
  end

end

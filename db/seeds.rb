# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first
Billing.destroy_all
Challenge.destroy_all
Player.destroy_all
Country.destroy_all
Language.destroy_all
Level.destroy_all
Tag.destroy_all

Level.create(name: 'Soldier', picture:'https://media.giphy.com/media/OvC4OMFLfMc8g/giphy.gif', points_required: 0)

10.times do
  Country.create(name: Faker::Address.country)
end

Language.create(name: 'Spanish')
Language.create(name: 'English')

Player.create(username: 'claudio', email: 'claudio@claudio.com', password: '123456', country_id: Country.last.id, level_id: Level.first.id, picture: Rails.root.join("test_player.png").open)

20.times do
  Player.create!(username: Faker::Internet.user_name, email: Faker::Internet.email, password: '123456', country_id: Country.order("RANDOM()").first.id, level_id: Level.first.id, picture: Rails.root.join("test_player.png").open)
end

30.times do
  Challenge.create!(
    title: Faker::Movie.quote,
    description: Faker::HitchhikersGuideToTheGalaxy.quote,
    local: [true, false].sample,
    capped: rand(0..500),
    block_size: rand(1..8),
    closing_date: rand(10.days).seconds.from_now,
    expiration_date: (rand(10.days).seconds.from_now + 10.days.seconds),
    language: Language.order("RANDOM()").first,
    creator: Player.order("RANDOM()").first,
    picture: Rails.root.join("test_challenge.png").open,
    status: 1
  )
end

45.times do
  Verifier.create!(
    description: Faker::BackToTheFuture.quote,
    challenge: Challenge.order("RANDOM()").first
  )
end

75.times do
  Party.create!(
    description: Faker::MostInterestingManInTheWorld.quote,
    weight: 0,
    challenge: Challenge.order("RANDOM()").first,
  )
end

300.times do
  Participation.create!(
    blocks: rand(1..25),
    player: Player.order("RANDOM()").first,
    party: Party.order("RANDOM()").first
  )
end

60.times do
  Tag.create(name: Faker::Book.genre)
end

90.times do
  ChallengeTag.create(challenge: Challenge.order("RANDOM()").first, tag: Tag.order("RANDOM()").first)
end

Challenge.all.each do |challenge|
  if challenge.parties.count < 2 || challenge.verifiers.count == 0 ||challenge.tags.count == 0
    challenge.delete
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

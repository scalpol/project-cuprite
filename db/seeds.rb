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
Level.destroy_all
Wallet.destroy_all
Participation.destroy_all
Confirmation.destroy_all


Level.create(name: 'Soldier', picture:'https://media.giphy.com/media/OvC4OMFLfMc8g/giphy.gif', points_required: 0)

10.times do
  Country.create(Faker::Address.country)
end

Language.create(name: 'Spanish')
Language.create(name: 'English')

Player.create(username: 'claudio', email: 'claudio@claudio.com', password: '123456', country_id: Country.last.id)

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

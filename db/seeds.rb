# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first
# Player.destroy_all
# Country.destroy_all
# Level.destroy_all
# Wallet.destroy_all
# Challenge.destroy_all
# Country.create(name: 'Chile')
# Country.create(name: 'Argentina')
# Country.create(name: 'Peru')
# Country.create(name: 'Brasil')
# Country.create(name: 'Venezuela')
# Country.create(name: 'Colombia')
# Level.create(name: 'Soldier', picture:'https://media.giphy.com/media/OvC4OMFLfMc8g/giphy.gif', points_required: 0)
# Language.create(name: 'Spanish')
# Language.create(name: 'English')
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

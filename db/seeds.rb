# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first
Player.destroy_all
Country.destroy_all
Level.destroy_all
Country.create(name: 'Chile')
Country.create(name: 'Argentina')
Country.create(name: 'Peru')
Country.create(name: 'Brasil')
Country.create(name: 'Venezuela')
Country.create(name: 'Colombia')
Level.create(name: 'soldier', picture:'https://media.giphy.com/media/OvC4OMFLfMc8g/giphy.gif', points_required: 0)
# revisar por que no guarda usuario nuevo
Player.create(email: 'claudio@claudio.com', username: 'claudio', password: '123456', picture: Faker::LoremPixel.image("50x60"), country: Country.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MiltsUnseen.destroy_all
MiltsRequest.destroy_all
Milt.destroy_all
Participation.destroy_all
Conversation.destroy_all
User.destroy_all

User.create(pseudo: "Maner", email: "maner@mail.com", password: "123456")
User.create(pseudo: "Alex", email: "alex@mail.com", password: "123456")
User.create(pseudo: "Seb", email: "seb@mail.com", password: "123456")
User.create(pseudo: "Camille", email: "camille@mail.com", password: "123456")
User.create(pseudo: "Paul", email: "paul@mail.com", password: "123456")
User.create(pseudo: "Jean", email: "jean@mail.com", password: "123456")
User.create(pseudo: "Simone", email: "paul@mail.com", password: "123456")

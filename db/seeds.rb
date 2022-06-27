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
Avatar.destroy_all

p "Creating users..."
maner = User.create(pseudo: "Maner", email: "maner@mail.com", password: "123456")
rachel = User.create(pseudo: "Rachel", email: "rachel@mail.com", password: "123456")
monica = User.create(pseudo: "Monica", email: "monica@mail.com", password: "123456")
phoebe = User.create(pseudo: "Phoebe", email: "phoebe@mail.com", password: "123456")
chandler = User.create(pseudo: "Chandler", email: "chandler@mail.com", password: "123456")
ross = User.create(pseudo: "Ross", email: "ross@mail.com", password: "123456")
joey = User.create(pseudo: "Joey", email: "joey@mail.com", password: "123456")
minou = User.create(pseudo: "Minou", email: "minou@mail.com", password: "123456")
p "Users created"

p "Creating avatars..."
rabbit = Avatar.create(emoji: "🐰")
frog = Avatar.create(emoji: "🐸")
cat = Avatar.create(emoji: "🐱")
bear = Avatar.create(emoji: "🐻")
dog = Avatar.create(emoji: "🐶")
cow = Avatar.create(emoji: "🐮")
lion = Avatar.create(emoji: "🦁")
lady = Avatar.create(emoji: "🐞")
crab = Avatar.create(emoji: "🦀")
mouse = Avatar.create(emoji: "🐭")
p "Avatars created"


p "Linking avatars to users..."
maner.update(avatar: rabbit)
rachel.update(avatar: lady)
monica.update(avatar: mouse)
phoebe.update(avatar: cow)
chandler.update(avatar: crab)
ross.update(avatar: dog)
joey.update(avatar: lion)
minou.update(avatar: cat)
p "All's good mf!"



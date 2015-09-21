# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Cats
counter = 1
10.times do
  Cat.create!(url: "http://lorempixel.com/400/200/cats/#{counter}", description: Faker::Lorem.paragraph(2))
  counter += 1
end

# Users

User.create!(username: "penelope", password: "boom111")
User.create!(username: "pepe", password: "boom111")

# Votes

TYPES = ["ZOMG! Cute!", "Amazing! So Beautiful!"]

counter = 1
10.times do
  rand(1..6).times do
    Cat.find(counter).votes.create!(category: TYPES.sample, IP_Address: Faker::Internet.ip_v6_address)
  end
  counter += 1
end



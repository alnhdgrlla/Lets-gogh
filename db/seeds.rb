# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

puts "Getting some dummy users..."

10.times do
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6),
    username: Faker::Internet.username
  )
  user.save!
end

puts "Goteem"

Supply.destroy_all

puts "Generating new supplies, please wait..."

10.times do
  supply = Supply.new(
    title: Faker::Hipster.words(number: 3).join(" "),
    price: Faker::Commerce.price(range: 0..500.0),
    category: Supply::CATEGORY.sample,
    description: Faker::Hipster.paragraphs(number: 2).join(" "),
    user_id: (1..10).to_a.sample
  )
  supply.save!
end

puts "Supplies are ready!"
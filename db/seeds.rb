# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying existing users..."
User.destroy_all if Rails.env.development?

puts "Getting some dummy users..."

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6),
    username: Faker::Internet.username
  )
end

puts "Goteem (#{User.count} times)"

puts "Destroying existing supplies..."
Supply.destroy_all if Rails.env.development?

puts "Generating new supplies, please wait..."

User.all.each do |user|
  rand(0..5).times do
    Supply.create!(
      title: Faker::Hipster.words(number: 3).join(" "),
      price: Faker::Commerce.price(range: 0..500.0),
      category: Supply::CATEGORY.sample,
      description: Faker::Hipster.paragraphs(number: 2).join(" "),
      user: user
    )
  end
end

puts "#{Supply.count} supplies are ready!"

puts "Destroying all bookings..."
Booking.destroy_all if Rails.env.development?

puts "Creating some new bookings..."

def adv_time
  n = rand(2..100)
  Date.today.advance(days: n)
end

10.times do
  Booking.create!(
    start_date: adv_time,
    end_date: adv_time + 3,
    user: User.all.sample,
    supply: Supply.all.sample
  )
end

puts "Successfully booked #{Booking.count} times"
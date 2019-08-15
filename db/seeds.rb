# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "Destroying all bookings..."
Booking.destroy_all

puts "Destroying existing supplies..."
Supply.destroy_all

puts "Destroying existing users..."
User.destroy_all

puts "Creating test supplier..."

test_supplier = User.new(
  email: "test@email.com",
  password: "123123",
  username: "wowowowow"
)
test_supplier.save!

puts "Creating test artist..."

test_artist = User.new(
  email: "artist@email.com",
  password: "123123",
  username: "okokokok"
)
test_artist.save!

puts "Creating test supply..."

Supply.create!(
  title: "Wacom tablet 2016",
  price: 30.99,
  category: "drawing tablet",
  description: "Impact Hub, Meguro",
  user: test_supplier,
  remote_photo_url: 'https://picsum.photos/70'
)

Supply.create!(
  title: "STANLEY Soft Grip Polyester Brush",
  price: 29.99,
  category: "paintbrushes",
  description: "McDonalds, Shibuya",
  user: test_supplier,
  remote_photo_url: 'https://cdn.shopify.com/s/files/1/1114/2810/products/waldorf-watercolor-paintbrush_1_1024x1024.png?v=1453489603'
)

Supply.create!(
  title: "Old Holland Classic Oil Colours",
  price: 40.99,
  category: "paints",
  description: "McDonalds, Shibuya",
  user: test_supplier,
  remote_photo_url: 'https://www.svgrepo.com/show/189152/paint-bucket-paint.svg'
)

puts "Creating test booking..."

Booking.create!(
  start_date: Date.today,
  end_date: Date.today + 3,
  user: test_artist,
  supply: Supply.first
)

puts "Test users ready to be used!"

puts "Getting some dummy users..."

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6),
    username: Faker::Internet.username
  )
end

puts "Goteem (#{User.count} times)"



puts "Generating new supplies, please wait..."

User.all.each do |user|
  rand(0..5).times do
    Supply.create!(
      title: Faker::Hipster.words(number: 3).join(" "),
      price: Faker::Commerce.price(range: 0..500.0),
      category: Supply::CATEGORY.sample,
      description: Faker::Hipster.paragraphs(number: 2).join(" "),
      user: user,
      remote_photo_url: 'https://picsum.photos/70'
    )
  end
end

puts "#{Supply.count} supplies are ready!"



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

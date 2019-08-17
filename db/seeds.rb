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
  username: "Starving Artist"
)
test_supplier.save!

puts "Creating test artist..."

test_artist = User.new(
  email: "artist@email.com",
  password: "123123",
  username: "Casual Hobbyist"
)
test_artist.save!

puts "Creating test supply..."

Supply.create!(
  title: "Wacom tablet 2016",
  price: 30.99,
  category: "drawing tablet",
  description: "My old Intuos Draw, don't really use anymore since I've upgraded to a 2019 Cintiq. Please handle with care, if you break it you buy it.",
  location: "Mos Burger, Meguro",
  user: test_supplier,
  remote_photo_url: 'https://wcm-cdn.azureedge.net/-/media/wacomdotcom/images/products/pen-tablets/intuos-art/gallery/cth490k_galleryimage_1_600x600_emea.jpg?h=600&la=en&w=600&hash=41DB178B0F18C5B1741D8B02755E2098'
)

Supply.create!(
  title: "STANLEY Soft Grip Polyester Brush",
  price: 29.99,
  category: "paintbrushes",
  description: "This paintbrush is by far the most consistent one from the STANLEY line. I have used it time and time again for my acrylic paintings, but these days I have moved toward watercolors. There's some light wear on the handle, but the bristles are in pristine condition.",
  location: "Mos Burger, Meguro",
  user: test_supplier,
  remote_photo_url: 'https://cdn.shopify.com/s/files/1/1114/2810/products/waldorf-watercolor-paintbrush_1_1024x1024.png?v=1453489603'
)

Supply.create!(
  title: "Artist Brand Acrylic Paints",
  price: 40.99,
  category: "paints",
  description: "Beautiful paints I have accumulated over the years. Please make beautiful paintings with them. Will update as I run out of particular colors. Current colors include: Black, Crimson Red, Yellow Ochre, Titanium White, Sap Green, Cobalt Blue",
  location: "Mos Burger, Meguro",
  user: test_supplier,
  remote_photo_url: 'https://images.pexels.com/photos/1327716/pexels-photo-1327716.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
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

usernames = [
  "mitch-sensei",
  "tanaka-san",
  "brykka",
  "the-real-dillon-wyatt",
  "jacque.desu",
  "doug-sempai",
  "seb.saunier",
  "sTeVeJoBs",
  "gates-kun",
  "simply sylvain"
]

usernames.each do |un|
  User.create!(
    email: Faker::Internet.email,
    password: "123123",
    username: un
  )
end

puts "Goteem (#{User.count} times)"

puts "Generating new supplies, please wait..."

photos = [
  "https://images.pexels.com/photos/933377/pexels-photo-933377.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/1152666/pexels-photo-1152666.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
  "https://images.pexels.com/photos/53190/colored-pencils-felt-tip-pens-color-crayons-53190.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
  "https://images.pexels.com/photos/2280913/pexels-photo-2280913.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
  "https://images.pexels.com/photos/1327216/pexels-photo-1327216.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/301792/pexels-photo-301792.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/6337/light-coffee-pen-working.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
]

titles = [
  "Limited Edition Fine Tip BIC Set",
  "Wacom Intuos Pro - 2015 - Small",
  "Samsung pen for Apple iPad Pro",
  "Prismacolor 156-color Box Set",
  "Greyscale COPIC Marker set (16 markers)",
  "A-Line Easel with Supply Stand"
]

locations = [
  "4000 Central Florida Blvd",
  "566 Laguardia Pl",
  "University of Washington, NE Pacific St",
  "Madison Square Park",
  "Shake Shack Ebisu Station"
]

review_contents = [
  "Really enjoyed using these supplies, was able to complete my hobby painting",
  "Incredibly smooth, would rent again",
  "I was able to pick up from the specified location without issue, truly amazing",
  "IT'S RAW! Haha j/k, it was okay",
  "wowowowowow okokokokokok",
  "Wow a 20 character limit on writing a review? What a shitty website, I hate it"
]

User.all.each do |user|
  rand(0..5).times do
    Supply.create!(
      title: titles.sample,
      price: Faker::Commerce.price(range: 0..5000),
      category: Supply::CATEGORY.sample,
      description: Faker::Hipster.paragraphs(number: 2).join(" "),
      location: locations.sample,
      user: user,
      remote_photo_url: photos.sample
    )
    Review.create!(
      content: review_contents.sample,
      user: user,
      supply: Supply.all.sample
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

puts "Faking some review..."



puts "#{Review.count} reviews created"

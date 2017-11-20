require 'faker'

def prepare
  puts "--- cleaning the db ---"
  User.destroy_all
  puts "    destroying all reviews..."
  Review.destroy_all
  puts "    destroying all runs..."
  Run.destroy_all
  puts "    destroying all events..."
  Event.destroy_all
  puts "--- database now clean ---"
  puts ""
end

def static_user
  puts "--- creating a static user ---"
    User.create!({
      email: "joe@gmail.com", password: "password",
      first_name: "Joe", last_name: "Alexander", photo: "https://picsum.photos/200/300/?random"
    })
  puts "    #{User.first.email} has been added to the db"
  puts "--- static user seeding completed ---"
  puts ""
end

def users(number)
  puts "    creating #{number} users"
  number.times {
    email = Faker::Internet.free_email
    password = "password"
    name = Faker::HarryPotter.character
    name = name.split
    first_name = name.first
    last_name = name.last
    photo = "https://picsum.photos/200/300/?random"
    User.create!({
      email: email, password: password,
      first_name: first_name,last_name: last_name, photo: photo
    })
  }
  puts "    #{User.last.email} has been added to the db"
  puts "--- user seeding completed ---"
  puts ""
end

def runs(number, user_id = User.all.ids.sample)
  puts "--- creating #{number} runs ---"
  number.times {
    location = Faker::Address.city
    photos = ["lix2bqmp4kzdpu4sqjiy","mgnhkqe23bgfg2uway9y","gdvenzf37gdoo6k9sspj", "ao1a6omwlx7gw2oabpoa", "ruhpzvv14g7bqysd6pxj", "op2mfyxt21d6mttstfdk", "xanuac8m6wjhlgxvi2zy", "pzxictxdgsc6mjkzq2sz", "noi6220drtm0csy2wxkm", "srf6dxogamsz5g1tk6og", "czhi6wgl4kyhaukjmxzz"]
    photo = "http://res.cloudinary.com/joycelewagon/image/upload/v1510744215/#{photos.sample}.jpg"
    maximum = Faker::Number.between(1, 4)
    capacity = (maximum / 2).round(0) + 1
    description = "A great run with #{capacity} people"
    date = Time.now
    Run.create!({
      user_id: user_id, location: location,
      remote_photo_url: photo, capacity: capacity, distance: 10,
      description: description, date: date
    })
  }
  puts "    #{Run.first.date} has been added to the db"
  puts "--- run seeding completed ---"
  puts ""
end

# def rentals(number, user_id = User.all.ids.sample, van_id = Van.all.ids.sample)
#   puts "--- creating #{number} rentals ---"
#   number.times {
#     days_forward = (rand() * 100).round(0)
#     days_rented = 7
#     start_date = Faker::Time.forward(days_forward, :morning)
#     end_date = Faker::Time.forward(days_forward + days_rented, :morning)
#     photos = ["lix2bqmp4kzdpu4sqjiy","mgnhkqe23bgfg2uway9y","gdvenzf37gdoo6k9sspj", "ao1a6omwlx7gw2oabpoa", "ruhpzvv14g7bqysd6pxj", "op2mfyxt21d6mttstfdk", "xanuac8m6wjhlgxvi2zy", "pzxictxdgsc6mjkzq2sz", "noi6220drtm0csy2wxkm", "srf6dxogamsz5g1tk6og", "czhi6wgl4kyhaukjmxzz"]
#     photo = "http://res.cloudinary.com/joycelewagon/image/upload/v1510744215/#{photos.sample}.jpg"
#     price = ((rand() * 100).round(0) + 20)*3
#     status = ["pending", "confirmed", "cancelled"].sample
#     Rental.create!({
#       start_date: start_date, end_date: end_date, remote_photo_url: photo,
#       price: price,status: status, user_id: user_id, van_id: van_id
#     })
#   }
#   puts "    A rental starting on #{Rental.first.start_date} has been added to the db"
#   puts "--- rental seeding completed ---"
#   puts ""
# end

# def reviews(number,  user_id = User.all.ids.sample, run_id = Run.all.ids.sample)
#   puts "--- creating #{number} rentals ---"
#   # Creating the review variables
#   date = ["January", "February", "March", "April" ,"May", "June", "July", "August", "September", "October", "November" ,"December"]
#   places = ["Newquay", "Penzance", "Bude", "Turo", "St Ives", "Looe", "Marazion","Falmouth", "Fowey", "Padstow"]
#   journey = ["forever", "a long time", "not too long", "a short while", "no time at all"]
#   owner = ["plain rude", "a bit unfriendly", "friendly", "really friendly", "superb"]
#   adjective1 = ["terrible", "poor", "so so", "good", "amazing"]
#   adjective2 = ["rusty", "tired", "good enough", "so comfy", "super cool"]
#   # Times iterator to create new class instances
#   number.times {
#     punctuality = ((1..5).to_a).sample
#     sample = score - 1
#     description = "I rented this van last #{date.sample} and had a #{adjective1[sample]} time. We drove down to #{places.sample} which took #{journey.sample}. The van itself was #{adjective2[sample]} and as for the owner they were just #{owner.sample}"
#     photos = ["lix2bqmp4kzdpu4sqjiy","mgnhkqe23bgfg2uway9y","gdvenzf37gdoo6k9sspj", "ao1a6omwlx7gw2oabpoa", "ruhpzvv14g7bqysd6pxj", "op2mfyxt21d6mttstfdk", "xanuac8m6wjhlgxvi2zy", "pzxictxdgsc6mjkzq2sz", "noi6220drtm0csy2wxkm", "srf6dxogamsz5g1tk6og", "czhi6wgl4kyhaukjmxzz"]
#     photo = "http://res.cloudinary.com/joycelewagon/image/upload/v1510744215/#{photos.sample}.jpg"
#     user_id = User.all.ids.sample
#     Review.create!({
#       description: description, remote_photo_url: photo
#     })
#   }
#   puts "    A review with a score of on #{Review.first.score} has been added to the db"
#   puts "--- review seeding completed ---"
#   puts ""
# end

prepare
puts "--- seeding the database ---"
# Creating the static user for the user journey
static_user
users(5)
# Creating 3 vans belonging to the static user for the user journey
runs(3)
# Creating random vans for seeded users
# vans(10)
# # Creating 5 rentals belonging to the static user for the user journey
# rentals(5, User.first.id)
# # Creating random rentals for seeded users
# rentals(10)
# # Creating random reviews for seeded users
# reviews(100)
# puts "whooop - all seeding completed :-)"

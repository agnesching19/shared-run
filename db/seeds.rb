require "faker"
require "open-uri"
require "nokogiri"

def prepare
  puts "--- cleaning the db ---"
  Search.destroy_all
  puts "    destroying all runs..."
  Run.destroy_all
  puts "--- cleaning the db ---"
  User.destroy_all
  puts "    destroying all reviews..."
  Review.destroy_all
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
    bio = "I love running!"
    User.create!({
      email: email, password: password,
      first_name: first_name,last_name: last_name, photo: photo
    })
  }
  puts "    #{User.last.email} has been added to the db"
  puts "--- user seeding completed ---"
  puts ""
end

def runs(number)
  puts "--- creating #{number} runs ---"
  number.times {
    user_id = User.all.ids.sample
    location = Faker::Address.city
    maximum = Faker::Number.between(1, 6)
    capacity = (maximum / 2).round(0) + 1
    title = "Amazing Run"
    description = "Have a great run with #{capacity} people"
    date = Faker::Date.forward(rand(0..60))
    distance = Faker::Number.between(1, 20)
    time = Time.now.strftime("at %I:%M%p")

    Run.create!({
      user_id: user_id, location: location,
      capacity: capacity, run_distance: distance,
      description: description, date: date,
      title: title, time:time
    })
    sleep(2)
  }

  puts "  New run #{Run.first.location} has been added to the database"
  puts "--- run seeding completed ---"
  puts ""
end

def events(number)

  puts "--- creating #{number} events ---"

  number.times {
    user_id = User.all.ids.sample
    date = Faker::Date.forward(rand(0..75))
    time = Time.now.strftime("at %I:%M%p")
    location = Faker::Address.city
    distance = Faker::Number.between(1, 20)
    description = "The run you can't miss this year!"
    price = rand(1..30)
    Event.create!({
      user_id: user_id, date: date, time: time, location: location,
      distance: distance, description: description, price: price
    })
  }

  puts "    An event on #{Event.first.date} has been added to the database"
  puts "--- event seeding completed ---"
  puts ""
end

def reviews(number)
  puts "--- creating #{number} reviews ---"

  number.times {
    user_id = User.all.ids.sample
    run_id = Run.all.ids.sample
    punctuality = [true, false].shuffle

    Review.create!({
      user_id: user_id, run_id: run_id, punctuality: punctuality
    })
  }
  puts "    A review with a figure of #{Review.first.punctuality} has been added to the database"
  puts "--- review seeding completed ---"
  puts ""
end

def scrape_events(number)
  url = "https://www.runnersworld.co.uk/event/search"
  html = open(url).read
  html_doc = Nokogiri::HTML(html)

  # number.times {
  html_doc.css('.results--list').first(number).each_with_index do |comp, index|
    puts index + 1
    date = comp.search('.results--date').text
    dates = date.split(' ')
    day = dates[1].to_i
    month = Date::MONTHNAMES.index(dates[2])
    year = dates[3]
    actual_date = Date.parse("#{day}/#{month}/#{year}")
    time = Time.parse(dates.last)
    # description =  tr.search('td')[1].text
    location = comp.search('.results--location').text
    description = comp.search('.events--title').text
    distance = (5..20).to_a.sample
    surface = ['Trail', 'Road', 'Track'].sample
    event = Event.new(date: actual_date, time: time, location: location, description: description, run_distance: distance, surface: surface)
    event.user = User.first
    event.save
    puts "----- #{description} created"
  end

end

prepare
puts "--- seeding the database ---"
# Creating the static user for the user journey
static_user
# Creating 5 users
# users(15)
# Creating 5 runs belonging to the random 5 users for the user journey
# runs(15)
# Creating 5 events belonging to the random 5 users for the user journey
# events(10)
# Creating random reviews for seeded users
# reviews(5)
# Creating scraped events for seeded users

scrape_events(10)

puts "whooop - all seeding completed ;)"

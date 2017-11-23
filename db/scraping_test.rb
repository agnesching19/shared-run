require 'open-uri'
require 'nokogiri'
require 'time'
require 'date'

url = "https://www.runnersworld.co.uk/event/search"
html = open(url).read
html_doc = Nokogiri::HTML(html)

# number.times {
html_doc.css('.results--list').first(10).each_with_index do |comp, index|
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
  puts '-----'
end

# }

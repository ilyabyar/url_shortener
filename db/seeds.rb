# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
countries_array = Carmen::Country.all.map(&:name).map do |country_name|
  Country.new(name: country_name)
end

links_array = []
15.times do
  link = Link.new(url: 'google.com')
  link.process!
  links_array.push(link)
end

ActiveRecord::Base.transaction do
  countries_array.map(&:save!)
  links_array.map(&:save!)
end

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 10.times do |index|
#   User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.paragraph(sentence_count: 2), email: "acme#{index}@yopmail.com", encrypted_password: Faker::Internet.password(min_length: 6))
# end

# puts "Users created"

20.times do |index|
  Event.create!(title: Faker::Lorem.sentence(word_count: 3), description: Faker::Lorem.paragraph(sentence_count: 2), start_date: Faker::Date.forward(days: 23), price: rand(1..1000), location: Faker::Address.city, admin_id: rand(1..10))
end

puts "Events created"

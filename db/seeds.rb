# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# puts "Clearing database"
# Message.destroy_all
# Member.destroy_all
# Susu.destroy_all
# User.destroy_all

# puts "Creating users"
# users = []
# users << User.create!(first_name: "Adam", last_name: "A", email: "adam@mysusu.com", password: "password")
# users << User.create!(first_name: "Bob", last_name: "B", email: "bob@mysusu.com", password: "password")
# users << User.create!(first_name: "Chris", last_name: "C", email: "chris@mysusu.com", password: "password")
# users << User.create!(first_name: "Dan", last_name: "D", email: "dan@mysusu.com", password: "password")
# users << User.create!(first_name: "Eve", last_name: "E", email: "eve@mysusu.com", password: "password")

# puts "#{User.count} users created"

# susu = Susu.create!(user_id: users[0].id, name: "Adams susu", balance: 500, agree_amount: 10, description: "This susu was set up by Adam to empower his community")

# puts "Adams susu has been created!"

# puts "Creating memberships"
# members = []
# members << Member.create!(susu_id: susu.id, user_id: users[0].id, join_date: "01/03/2023", balance: 100, status: 1)
# members << Member.create!(susu_id: susu.id, user_id: users[1].id, join_date: "02/03/2023", balance: 100)
# members << Member.create!(susu_id: susu.id, user_id: users[2].id, join_date: "03/03/2023", balance: 100)
# members << Member.create!(susu_id: susu.id, user_id: users[3].id, join_date: "04/03/2023", balance: 100)
# members << Member.create!(susu_id: susu.id, user_id: users[4].id, join_date: "05/03/2023", balance: 100)

# puts "Members have been assigned to a susu."

# deposits = []
# deposits << Deposit.create!(member_id: members[0].id, date: Date.today, susu_id: susu.id, agree_amount: 100)

# puts "Created one deposit for Adam"

require 'faker'

puts "Clearing database"
Message.destroy_all
Member.destroy_all
Susu.destroy_all
User.destroy_all

puts "Creating users"
users = []

users << User.create!(first_name: "Adam", last_name: "A", email: "adam@mysusu.com", password: "password")
users << User.create!(first_name: "Bob", last_name: "B", email: "bob@mysusu.com", password: "password")
users << User.create!(first_name: "Chris", last_name: "C", email: "chris@mysusu.com", password: "password")
users << User.create!(first_name: "Dan", last_name: "D", email: "dan@mysusu.com", password: "password")
users << User.create!(first_name: "Eve", last_name: "E", email: "eve@mysusu.com", password: "password")

puts "#{User.count} users created"

susu_descriptions = [
  "This susu was created to support community projects in the local area.",
  "Join this susu to save for your dream vacation!",
  "Our susu helps members save money for emergencies and unexpected expenses."
]

puts "Creating susus"
susus = []
susu_descriptions.each_with_index do |description, index|
  susus << Susu.create!(
    user_id: users.sample.id,
    name: "Susu #{index + 1}",
    balance: 500,
    agree_amount: 10,
    description: description
  )
end

puts "#{Susu.count} susus created"

puts "Creating memberships"
members = []
susus.each do |susu|
  members << Member.create!(
    susu_id: susu.id,
    user_id: users.sample.id,
    join_date: Date.today,
    balance: 100,
    status: "accepted"
  )
end

puts "#{Member.count} members have been assigned to a susu."

puts "Creating deposits"
deposits = []
members.each do |member|
  deposits << Deposit.create!(
    member_id: member.id,
    date: Date.today,
    susu_id: member.susu.id,
    agree_amount: 100
  )
end

puts "#{Deposit.count} deposits created"

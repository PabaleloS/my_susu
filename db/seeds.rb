# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Clearing database"
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

susu = Susu.create!(user_id: users[0].id, name: "Adams susu", balance: 500, description: "This susu was set up by Adam to empower his community")

puts "Adams susu has been created!"

member = Member.create!(susu_id: susu.id, user_id: users[0].id, join_date: "01/03/2023", balance: 100)
member = Member.create!(susu_id: susu.id, user_id: users[1].id, join_date: "02/03/2023", balance: 100)
member = Member.create!(susu_id: susu.id, user_id: users[2].id, join_date: "03/03/2023", balance: 100)
member = Member.create!(susu_id: susu.id, user_id: users[3].id, join_date: "04/03/2023", balance: 100)
member = Member.create!(susu_id: susu.id, user_id: users[4].id, join_date: "05/03/2023", balance: 100)

puts "members have been assigned to a susu"

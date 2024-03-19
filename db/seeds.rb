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
Message.destroy_all
Member.destroy_all
Susu.destroy_all
User.destroy_all

puts "Creating 3 Susus and their owners.."

adam = User.create!(first_name: "Adam", last_name: "A", email: "adam@mysusu.com", password: "password")
adam_susu = Susu.create!(user: adam, name: "Adam's Susu", balance: 0, agree_amount: 500, description: "This susu was created to support community projects in the local area.")
adam_member = Member.create!(susu: adam_susu, user: adam, join_date: Date.today, balance: 0, status: "accepted")

bob = User.create!(first_name: "Bob", last_name: "B", email: "bob@mysusu.com", password: "password")
bob_susu = Susu.create!(user: bob, name: "Bob's Susu", balance: 0, agree_amount: 1000, description: "Join this susu to save for your dream vacation!")
bob_member = Member.create!(susu: bob_susu, user: bob, join_date: Date.today, balance: 0, status: "accepted")

eve = User.create!(first_name: "Eve", last_name: "E", email: "eve@mysusu.com", password: "password")
eve_susu = Susu.create!(user: eve, name: "Eve's Susu", balance: 0, agree_amount: 1500, description: "Our susu helps members save money for emergencies and unexpected expenses.")
eve_member = Member.create!(susu: eve_susu, user: eve, join_date: Date.today, balance: 0, status: "accepted")

puts "3 Susus and their owners created"

puts "Creating some app users and adding members to existing Susus..."

user1 = User.create!(first_name: "Akshan", last_name: "A", email: "akshan@mysusu.com", password: "password")
user2 = User.create!(first_name: "Brand", last_name: "B", email: "brand@mysusu.com", password: "password")
user3 = User.create!(first_name: "Camille", last_name: "C", email: "camille@mysusu.com", password: "password")
user4 = User.create!(first_name: "Darius", last_name: "D", email: "darius@mysusu.com", password: "password")
user5 = User.create!(first_name: "Evelynn", last_name: "E", email: "evelynn@mysusu.com", password: "password")
user6 = User.create!(first_name: "Fiora", last_name: "F", email: "fiora@mysusu.com", password: "password")
user7 = User.create!(first_name: "Gragussy", last_name: "G", email: "gragussy@mysusu.com", password: "password")
user8 = User.create!(first_name: "Hwei", last_name: "H", email: "hwei@susu.com", password: "password")
user9 = User.create!(first_name: "Irelia", last_name: "I", email: "irelia@mysusu.com", password: "password")
user10 = User.create!(first_name: "Jhin", last_name: "J", email: "jhin@mysusu.com", password: "password")
user11 = User.create!(first_name: "Kai'sa", last_name: "K", email: "kaisa@mysusu.com", password: "password")
user12 = User.create!(first_name: "Lee Sin", last_name: "L", email: "leesin@mysusu.com", password: "password")
user13 = User.create!(first_name: "Malphite", last_name: "M", email: "malphite@mysusu.com", password: "password")
user14 = User.create!(first_name: "Nasus", last_name: "N", email: "nasus@mysusu.com", password: "password")
user15 = User.create!(first_name: "Ornn", last_name: "O", email: "ornn@mysusu.com", password: "password")
user16 = User.create!(first_name: "Pyke", last_name: "P", email: "pyke@mysusu.com", password: "password")
user17 = User.create!(first_name: "Qiyana", last_name: "Q", email: "qiyana@mysusu.com", password: "password")
user18 = User.create!(first_name: "Rengar", last_name: "R", email: "rengar@mysusu.com", password: "password")
user19 = User.create!(first_name: "Shaco", last_name: "S", email: "shaco@mysusu.com", password: "password")
user20 = User.create!(first_name: "Thresh", last_name: "T", email: "thresh@mysusu.com", password: "password")

puts "#{User.count} users created"

puts "Adding members to Adam's Susu..."

adam_member_1 = Member.create!(susu: adam_susu, user: user1, join_date: Date.today, balance: 0, status: "accepted")
adam_member_2 = Member.create!(susu: adam_susu, user: user2, join_date: Date.today, balance: 0, status: "accepted")
adam_member_3 = Member.create!(susu: adam_susu, user: user3, join_date: Date.today, balance: 0, status: "accepted")

puts "#{Member.count} members have been assigned to Adam's susu."

puts "Adding members to Bob's Susu..."

bob_member_1 = Member.create!(susu: bob_susu, user: user4, join_date: Date.today, balance: 0, status: "accepted")
bob_member_2 = Member.create!(susu: bob_susu, user: user5, join_date: Date.today, balance: 0, status: "accepted")
bob_member_3 = Member.create!(susu: bob_susu, user: user6, join_date: Date.today, balance: 0, status: "accepted")

puts "#{Member.count} members have been assigned to Bob's susu."

puts "Adding members to Eve's Susu..."

eve_member_1 = Member.create!(susu: eve_susu, user: user7, join_date: Date.today, balance: 0, status: "accepted")
eve_member_2 = Member.create!(susu: eve_susu, user: user8, join_date: Date.today, balance: 0, status: "accepted")
eve_member_3 = Member.create!(susu: eve_susu, user: user9, join_date: Date.today, balance: 0, status: "accepted")

puts "#{Member.count} members have been assigned to Eve's susu."

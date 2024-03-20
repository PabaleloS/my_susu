# This file should ensure the existence of records required to run the application in maxry environment (production,
# dmaxlopment, test). The code here should be idempotent so that it can be executed at any point in maxry environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"

puts "Clearing database"
Message.destroy_all
Member.destroy_all
Susu.destroy_all
User.destroy_all

puts "Creating 3 Susus and their owners.."

sam = User.create!(first_name: "Sam", last_name: "S", email: "sam@mysusu.com", password: "password")
sam_file = URI.open("https://thispersondoesnotexist.com")
sam.photo.attach(io: sam_file, filename: "avatar.png", content_type: "image/png")
sam_susu = Susu.create!(user: sam, name: "Sam's Susu", balance: 0, agree_amount: 500, description: "This susu was created to support community projects in the local area.")
sam_member = Member.create!(susu: sam_susu, user: sam, join_date: Date.today, balance: 0, status: "accepted")

lee = User.create!(first_name: "Lee", last_name: "L", email: "lee@mysusu.com", password: "password")
lee_file = URI.open("https://thispersondoesnotexist.com")
lee.photo.attach(io: lee_file, filename: "avatar.png", content_type: "image/png")
lee_susu = Susu.create!(user: lee, name: "Lee's Susu", balance: 0, agree_amount: 1000, description: "Join this susu to save for your dream vacation!")
lee_member = Member.create!(susu: lee_susu, user: lee, join_date: Date.today, balance: 0, status: "accepted")

max = User.create!(first_name: "Max", last_name: "M", email: "max@mysusu.com", password: "password")
max_file = URI.open("https://thispersondoesnotexist.com")
max.photo.attach(io: max_file, filename: "avatar.png", content_type: "image/png")
max_susu = Susu.create!(user: max, name: "Max's Susu", balance: 0, agree_amount: 1500, description: "Our susu helps members save money for emergencies and unexpected expenses.")
max_member = Member.create!(susu: max_susu, user: max, join_date: Date.today, balance: 0, status: "accepted")

puts "3 Susus and their owners created"

puts "Creating some app users and adding members to existing Susus..."

user1 = User.create!(first_name: "Aubrey", last_name: "A", email: "akshan@mysusu.com", password: "password")
user1_file = URI.open("https://thispersondoesnotexist.com")
user1.photo.attach(io: user1_file, filename: "avatar.png", content_type: "image/png")
user2 = User.create!(first_name: "Blake", last_name: "B", email: "brand@mysusu.com", password: "password")
user2_file = URI.open("https://thispersondoesnotexist.com")
user2.photo.attach(io: user2_file, filename: "avatar.png", content_type: "image/png")
user3 = User.create!(first_name: "Charlie", last_name: "C", email: "camille@mysusu.com", password: "password")
user3_file = URI.open("https://thispersondoesnotexist.com")
user3.photo.attach(io: user3_file, filename: "avatar.png", content_type: "image/png")
user4 = User.create!(first_name: "Dylan", last_name: "D", email: "darius@mysusu.com", password: "password")
user4_file = URI.open("https://thispersondoesnotexist.com")
user4.photo.attach(io: user4_file, filename: "avatar.png", content_type: "image/png")
user5 = User.create!(first_name: "Ellis", last_name: "E", email: "maxlynn@mysusu.com", password: "password")
user5_file = URI.open("https://thispersondoesnotexist.com")
user5.photo.attach(io: user5_file, filename: "avatar.png", content_type: "image/png")
user6 = User.create!(first_name: "Francis", last_name: "F", email: "fiora@mysusu.com", password: "password")
user6_file = URI.open("https://thispersondoesnotexist.com")
user6.photo.attach(io: user6_file, filename: "avatar.png", content_type: "image/png")
user7 = User.create!(first_name: "Gene", last_name: "G", email: "gragussy@mysusu.com", password: "password")
user7_file = URI.open("https://thispersondoesnotexist.com")
user7.photo.attach(io: user7_file, filename: "avatar.png", content_type: "image/png")
user8 = User.create!(first_name: "Harper", last_name: "H", email: "hwei@susu.com", password: "password")
user8_file = URI.open("https://thispersondoesnotexist.com")
user8.photo.attach(io: user8_file, filename: "avatar.png", content_type: "image/png")
user9 = User.create!(first_name: "Indigo", last_name: "I", email: "irelia@mysusu.com", password: "password")
user9_file = URI.open("https://thispersondoesnotexist.com")
user9.photo.attach(io: user9_file, filename: "avatar.png", content_type: "image/png")

puts "#{User.count} users created"

puts "Adding members to Sam's Susu..."

sam_member_1 = Member.create!(susu: sam_susu, user: user1, join_date: Date.today, balance: 0, status: "accepted")
sam_member_2 = Member.create!(susu: sam_susu, user: user2, join_date: Date.today, balance: 0, status: "accepted")
sam_member_3 = Member.create!(susu: sam_susu, user: user3, join_date: Date.today, balance: 0, status: "accepted")

puts "Adding members to Lee's Susu..."

lee_member_1 = Member.create!(susu: lee_susu, user: user4, join_date: Date.today, balance: 0, status: "accepted")
lee_member_2 = Member.create!(susu: lee_susu, user: user5, join_date: Date.today, balance: 0, status: "accepted")
lee_member_3 = Member.create!(susu: lee_susu, user: user6, join_date: Date.today, balance: 0, status: "accepted")

puts "Adding members to Max's Susu..."

max_member_1 = Member.create!(susu: max_susu, user: user7, join_date: Date.today, balance: 0, status: "accepted")
max_member_2 = Member.create!(susu: max_susu, user: user8, join_date: Date.today, balance: 0, status: "accepted")
max_member_3 = Member.create!(susu: max_susu, user: user9, join_date: Date.today, balance: 0, status: "accepted")

puts "#{Member.count} members have been assigned to susus."

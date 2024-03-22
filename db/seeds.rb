# This file should ensure the existence of records required to run the application in pabalelory environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in pabalelory environment.
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

christopher = User.create!(first_name: "Christopher", last_name: "S", email: "christopher@mysusu.com", password: "password")
christopher_file = URI.open("https://avatars.githubusercontent.com/u/88435948?v=4")
christopher.photo.attach(io: christopher_file, filename: "avatar.png", content_type: "image/png")
christopher.save
christopher_susu = Susu.create!(user: christopher, name: "Christopher's Susu", balance: 0, agree_amount: 500, description: "This susu was created to support community projects in the local area.")
christopher_member = Member.create!(susu: christopher_susu, user: christopher, join_date: Date.today, balance: 0, status: "accepted")

kingsley = User.create!(first_name: "Kingsley", last_name: "L", email: "kingsley@mysusu.com", password: "password")
kingsley_file = URI.open("https://avatars.githubusercontent.com/u/157271602?v=4")
kingsley.photo.attach(io: kingsley_file, filename: "avatar.png", content_type: "image/png")
kingsley.save
kingsley_susu = Susu.create!(user: kingsley, name: "Kingsley's Susu", balance: 0, agree_amount: 1000, description: "Join this susu to save for your dream vacation!")
kingsley_member = Member.create!(susu: kingsley_susu, user: kingsley, join_date: Date.today, balance: 0, status: "accepted")

pabalelo = User.create!(first_name: "Pabalelo", last_name: "M", email: "pabalelo@mysusu.com", password: "password")
pabalelo_file = URI.open("https://avatars.githubusercontent.com/u/114606058?v=4")
pabalelo.photo.attach(io: pabalelo_file, filename: "avatar.png", content_type: "image/png")
pabalelo.save
pabalelo_susu = Susu.create!(user: pabalelo, name: "Pabalelo's Susu", balance: 0, agree_amount: 1500, description: "Our susu helps members save money for emergencies and unexpected expenses.")
pabalelo_member = Member.create!(susu: pabalelo_susu, user: pabalelo, join_date: Date.today, balance: 0, status: "accepted")

puts "3 Susus and their owners created"

puts "Creating some app users and adding members to existing Susus..."

user1 = User.create!(first_name: "Aubrey", last_name: "A", email: "aubrey@mysusu.com", password: "password")
user1_file = URI.open("https://thispersondoesnotexist.com")
user1.photo.attach(io: user1_file, filename: "avatar.png", content_type: "image/png")
user1.save
user2 = User.create!(first_name: "Blake", last_name: "B", email: "blake@mysusu.com", password: "password")
user2_file = URI.open("https://thispersondoesnotexist.com")
user2.photo.attach(io: user2_file, filename: "avatar.png", content_type: "image/png")
user2.save
user3 = User.create!(first_name: "Charlie", last_name: "C", email: "charlie@mysusu.com", password: "password")
user3_file = URI.open("https://thispersondoesnotexist.com")
user3.photo.attach(io: user3_file, filename: "avatar.png", content_type: "image/png")
user3.save
user4 = User.create!(first_name: "Dylan", last_name: "D", email: "dylan@mysusu.com", password: "password")
user4_file = URI.open("https://thispersondoesnotexist.com")
user4.photo.attach(io: user4_file, filename: "avatar.png", content_type: "image/png")
user4.save
user5 = User.create!(first_name: "Ellis", last_name: "E", email: "ellis@mysusu.com", password: "password")
user5_file = URI.open("https://thispersondoesnotexist.com")
user5.photo.attach(io: user5_file, filename: "avatar.png", content_type: "image/png")
user5.save
user6 = User.create!(first_name: "Francis", last_name: "F", email: "francis@mysusu.com", password: "password")
user6_file = URI.open("https://thispersondoesnotexist.com")
user6.photo.attach(io: user6_file, filename: "avatar.png", content_type: "image/png")
user6.save
user7 = User.create!(first_name: "Gene", last_name: "G", email: "gene@mysusu.com", password: "password")
user7_file = URI.open("https://thispersondoesnotexist.com")
user7.photo.attach(io: user7_file, filename: "avatar.png", content_type: "image/png")
user7.save
user8 = User.create!(first_name: "Harper", last_name: "H", email: "harper@susu.com", password: "password")
user8_file = URI.open("https://thispersondoesnotexist.com")
user8.photo.attach(io: user8_file, filename: "avatar.png", content_type: "image/png")
user8.save
user9 = User.create!(first_name: "Indigo", last_name: "I", email: "indigo@mysusu.com", password: "password")
user9_file = URI.open("https://thispersondoesnotexist.com")
user9.photo.attach(io: user9_file, filename: "avatar.png", content_type: "image/png")
user9.save

puts "#{User.count} users created"

puts "Adding members to Christopher's Susu..."

christopher_member_1 = Member.create!(susu: christopher_susu, user: user1, join_date: Date.today, balance: 0, status: "accepted")
christopher_member_2 = Member.create!(susu: christopher_susu, user: user2, join_date: Date.today, balance: 0, status: "accepted")
christopher_member_3 = Member.create!(susu: christopher_susu, user: user3, join_date: Date.today, balance: 0, status: "accepted")

puts "Adding members to Kingsley's Susu..."

kingsley_member_1 = Member.create!(susu: kingsley_susu, user: user4, join_date: Date.today, balance: 0, status: "accepted")
kingsley_member_2 = Member.create!(susu: kingsley_susu, user: user5, join_date: Date.today, balance: 0, status: "accepted")
kingsley_member_3 = Member.create!(susu: kingsley_susu, user: user6, join_date: Date.today, balance: 0, status: "accepted")

puts "Adding members to Pabalelo's Susu..."

pabalelo_member_1 = Member.create!(susu: pabalelo_susu, user: user7, join_date: Date.today, balance: 0, status: "accepted")
pabalelo_member_2 = Member.create!(susu: pabalelo_susu, user: user8, join_date: Date.today, balance: 0, status: "accepted")
pabalelo_member_3 = Member.create!(susu: pabalelo_susu, user: user9, join_date: Date.today, balance: 0, status: "accepted")

puts "#{Member.count} members have been assigned to susus."

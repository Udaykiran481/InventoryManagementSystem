# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

# Delete existing records in the tables
User.delete_all
Employee.delete_all
Brand.delete_all
Category.delete_all

# Create two admin users
User.create!(
  name: "Admin User",
  email: "admin@example.com",
  password_digest: BCrypt::Password.create("123"),
  role: "admin"
)

2.times do
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  password = "123"  # Assuming you want a static password for admin users

  User.create!(
    name: name,
    email: email,
    password_digest: BCrypt::Password.create(password),
    role: "admin"
  )
end

# Create regular users
8.times do
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  password = "123"  # Assuming you want a static password for regular users

  User.create!(
    name: name,
    email: email,
    password_digest: BCrypt::Password.create(password)
  )
end

# Create brand records with Faker
brand_names = ["HP", "Dell", "Samsung", "Anil Furniture", "Lenovo"]

brand_names.each do |brand_name|
  Brand.create!(
    name: brand_name
  )
end

# Create category records with Faker
category_data = [
  { name: "Laptop", initial_quantity: 15 },
  { name: "Charger", initial_quantity: 15 },
  { name: "Monitor", initial_quantity: 15 },
  { name: "RAM", initial_quantity: 10 },
  { name: "Memory cards", initial_quantity: 10 },
  { name: "Chairs", initial_quantity: 20 },
  { name: "Tables", initial_quantity: 20 }
]

category_data.each do |category|
  Category.create!(
    name: category[:name],
    buffer_quantity: category[:initial_quantity],
    quantity: category[:initial_quantity]
  )
end






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
Brand.delete_all
Category.delete_all

# Create user records with Faker
10.times do
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  password = Faker::Internet.password

  User.create!(
    name: name,
    email: email,
    password_digest: BCrypt::Password.create(password)
  )
end

# Create brand records with Faker
10.times do
  brand_name = Faker::Company.unique.name

  Brand.create!(
    name: brand_name
  )
end

# Create category records with Faker
10.times do
  category_name = Faker::Commerce.unique.department
  initial_quantity = Faker::Number.between(from: 10, to: 100)

  Category.create!(
    name: category_name,
    buffer_quantity: initial_quantity,
    quantity: initial_quantity
  )
end






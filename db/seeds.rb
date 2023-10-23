# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

# Delete existing records in the tables
User.destroy_all
Employee.destroy_all
Brand.destroy_all
Category.destroy_all
Notification.destroy_all
Issue.destroy_all
Invitation.destroy_all
Item.destroy_all

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
  password = "123"  

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
  password = "123"  

  User.create!(
    name: name,
    email: email,
    password_digest: BCrypt::Password.create(password)
  )
end

# Create brand records 
brand_names = ["HP", "Dell", "Samsung", "Anil Furniture", "Lenovo"]

brand_names.each do |brand_name|
  Brand.create!(
    name: brand_name
  )
end

# Create category records 
category_data = [
  { name: "Laptop", initial_quantity: 15 },
  { name: "Charger", initial_quantity: 15 },
  { name: "Monitor", initial_quantity: 15 },
  { name: "RAM", initial_quantity: 10 },
  { name: "Memory cards", initial_quantity: 10 },
  { name: "Chairs", initial_quantity: 20 }
]

category_data.each do |category|
  Category.create!(
    name: category[:name],
    buffer_quantity: category[:initial_quantity],
    quantity: category[:initial_quantity]
  )
end


#item seed
def create_item_with_functions(name, brand_id, category_id, employee_id)
  item = Item.create(
    name: name,
    brand_id: brand_id,
    category_id: category_id,
    employee_id: employee_id,
    status: "Working"
  )

  # Check if the Item is saved successfully
  if item.save
    if item.employee_id?
      puts item.employee_id

      # Retrieve the associated category
      category = item.category

      # Check if the category exists
      if category
        # Call the update_buffer_quantity method
        category.update_buffer_quantity(1)

        # Call the check_and_send_notifications method
        category.check_and_send_notifications(item)
      end
    end
  end
end

# Create Items and call functions
3.times do |i|
  create_item_with_functions("Laptop", 1, 1, i + 4)
end

2.times do |i|
  create_item_with_functions("Laptop", 2, 1, i + 7)
end

3.times do |i|
  create_item_with_functions("Charger", 1, 2, i + 4)
end

3.times do |i|
  create_item_with_functions("SD Card", 3, 5, i + 4)
end

3.times do |i|
  create_item_with_functions("Chairs", 4, 6, i + 4)
end





















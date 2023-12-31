# Inventory Management System

The Inventory Management System is a web application built with Ruby on Rails for efficient inventory control and management. It offers features to manage items, allocate inventory to employees, track stock levels, and handle item-related issues.

## Key Features

- **Item Management**: Add, edit, and categorize items in your inventory.
- **Employee Allocation**: Allocate items to employees, monitor quantities, and set buffer levels.
- **Real-time Notifications**: Receive notifications for low stock levels and item allocation changes.
- **Issue Tracking**: Employees can report item-related issues, and administrators can resolve issues.
- **Elasticsearch Integration**: Utilize Elasticsearch for quick and powerful item and category search.
- **User Authentication**: Secure user accounts with login and authorization features.


## Installation

* **Clone this repository:**

   ```bash
   git clone https://github.com/Udaykiran481/InventoryManagementSystem.git
## Requirements

The setups steps expect following tools installed on the system.

* **Rails 6.1.7.6**
* **Ruby 3.1.2**


## Install system dependencies

```bash
bundle install
yarn install
```

## Initialize the database

```bash
rails db:create db:migrate db:seed
```

## Start the Rails server

You can start the rails server using the command given below.

```bash
rails s
```

And now you can visit the site with the URL http://localhost:3000


## Admin login

### Email: admin@example.com
### Password: Password@123

## User's login
#### Email is generated by faker and can be retrived  by employees section in admin dashboard
#### Password: Password@123  


## Extra gems used
* bcrypt
* omniauth
* omniauth-google-oauth2
* omniauth-rails_csrf_protection
* elasticsearch-model
* elasticsearch-rails
* faker
* letter_opener

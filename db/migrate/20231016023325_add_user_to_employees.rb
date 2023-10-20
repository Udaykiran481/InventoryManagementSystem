class AddUserToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_reference :employees, :user, foreign_key: true
  end
end

class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :message
      t.integer :priority, default: 0
      t.references :category, foreign_key: true
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true  
      t.timestamps
    end
  end
end

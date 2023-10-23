class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :message
      t.integer :priority, default: 0
      t.references :category, foreign_key: true
      t.references :issue, foreign_key: true, optional: true
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :read, default: false
      t.integer :buffer_quantity, default: 0
      t.timestamps precision: 6, null: false
    end
  end
end






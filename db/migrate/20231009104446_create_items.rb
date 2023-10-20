class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :brand_id, null: false
      t.integer :category_id, null: false
      t.integer :employee_id
      t.string :status, null: false
      t.text :notes
      t.string :item_document
      t.timestamps precision: 6, null: false
    end

    add_foreign_key :items, :brands
    add_foreign_key :items, :categories
    add_foreign_key :items, :users, column: :employee_id
  end
end


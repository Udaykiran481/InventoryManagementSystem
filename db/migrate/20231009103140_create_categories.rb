class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :buffer_quantity
      t.integer :quantity
      t.timestamps precision: 6
    end
  end
end

class CreateStorageItems < ActiveRecord::Migration[6.1]
  def change
    create_table :storage_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end



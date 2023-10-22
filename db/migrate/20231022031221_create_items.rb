class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.references :brand, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :employee, references: :users
      t.string :status, null: false
      t.text :notes
      t.string :item_document
      t.timestamps precision: 6, null: false
    end
  end
end

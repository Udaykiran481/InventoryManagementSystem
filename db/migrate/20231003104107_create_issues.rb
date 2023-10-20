class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.text :description
      t.boolean :resolved
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true 

      t.timestamps
    end
  end
end

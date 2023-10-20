class AddReferencesToIssue < ActiveRecord::Migration[6.1]
  def change
    add_reference :issues, :user, foreign_key: true
    add_reference :issues, :item, foreign_key: true
  end
end

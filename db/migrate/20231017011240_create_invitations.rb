class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.string :name
      t.string :email
      t.string :invitation_token

      t.timestamps
    end
  end
end

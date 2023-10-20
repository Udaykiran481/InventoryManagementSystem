class AddIssueReferenceToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :issue, foreign_key: true, optional: true
  end
end

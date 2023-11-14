class Issue < ApplicationRecord
    belongs_to :user
    belongs_to :item
    has_many :notifications, dependent: :destroy
    validates :description, presence: true
    validates :item, presence: true
end

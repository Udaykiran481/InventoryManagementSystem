class StorageItem < ApplicationRecord
  belongs_to :item
  belongs_to :category
end

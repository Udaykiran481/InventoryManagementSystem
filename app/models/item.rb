class Item < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
  
    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :name, type: 'text'
      end
    end

    def as_indexed_json(_options = {})
        {
          name: name
        }
    end
    
    belongs_to :brand
    belongs_to :category
    belongs_to :employee, class_name: 'User', foreign_key: 'employee_id', optional: true
    has_one_attached :item_document
    has_one :storage_item
    has_many :notifications
    has_one :issue
    validates :name, presence: true
    has_many :issues,dependent: :destroy

end


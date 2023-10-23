class Brand < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    validates :name, presence: true, uniqueness: true
    has_many :items
  
    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :name, type: 'text', analyzer: 'english'
      end
    end
  

    def as_indexed_json(_options = {})
        {
        name: name  
        }
    end
end

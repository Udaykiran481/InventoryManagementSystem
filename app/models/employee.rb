class Employee < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

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
  belongs_to :user
  has_many :items
end


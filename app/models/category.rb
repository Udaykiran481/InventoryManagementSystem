class Category < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    settings index: { number_of_shards: 1 } do
        mappings dynamic: 'false' do
          indexes :name, type: 'text'
          indexes :quantity, type: 'integer'
          indexes :buffer_quantity, type: 'integer'
        end
      end
    
      def as_indexed_json(_options = {})
        {
          name: name,
          quantity: quantity,
          buffer_quantity: buffer_quantity
        }
      end

    has_one :storage_item
    has_many :items
    has_many :notification
    validates :name, presence: true, uniqueness: true
    validates :quantity, presence: true, numericality: { only_integer: true }
    validates :buffer_quantity, presence: true, numericality: { only_integer: true }
    validate :buffer_quantity_not_greater_than_quantity

    def update_buffer_quantity(decrease_by)
        new_buffer_quantity = buffer_quantity - decrease_by
        update(buffer_quantity: new_buffer_quantity)
    end
    
    def check_and_send_notifications(item)
        low_threshold = quantity * 0.8
        medium_threshold = quantity * 0.5
        high_threshold = quantity * 0.2
        admin_users = User.where(role: 'admin')
        admin_users.each do |user|
            if buffer_quantity <= high_threshold
                user.notifications.create(priority: :high, message: "High priority notification: Buffer quantity is low.",  item_id: item.id,category_id:id,buffer_quantity:self.buffer_quantity)
            elsif buffer_quantity <= medium_threshold
                user.notifications.create(priority: :medium, message: "Medium priority notification: Buffer quantity is getting lesser .",  item_id: item.id,category_id:id,buffer_quantity:self.buffer_quantity)
            elsif buffer_quantity <= low_threshold
                user.notifications.create(priority: :low, message: "Low priority notification: Buffer quantity is getting low.",  item_id: item.id,category_id:id,buffer_quantity:self.buffer_quantity) 
            end
        end
    end
    private

  def buffer_quantity_not_greater_than_quantity
    if buffer_quantity.present? && quantity.present? && buffer_quantity > quantity
      errors.add(:buffer_quantity, "cannot be greater than the quantity")
    end
  end
end









  
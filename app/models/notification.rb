class Notification < ApplicationRecord
    belongs_to :category
    belongs_to :item
    belongs_to :user
    belongs_to :issue , optional: true
  
    enum priority: { low: 0, medium: 1, high: 2 }
    validates :read, inclusion: { in: [true, false] }
    validates :message, presence: true
    def priority_class
      case priority
      when 'high' then 'danger'
      when 'medium' then 'warning'
      when 'low' then 'success'
      else 'primary'
      end
    end


  end
  
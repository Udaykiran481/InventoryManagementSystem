class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :password_digest, presence: true ,on: :create
    validates :password, presence: true, on: :create
    validate :password_complexity, on: :create
    enum role: { employee: 0, admin: 1 }
    has_secure_password
    has_one :employee
    has_many :items, foreign_key: 'employee_id'
    has_many :notifications
    has_many :issues,dependent: :destroy
    

    def admin?
        role == 'admin'
    end

    def unread_notification_count
        notifications.where(read: false).count
    end

    after_create :create_employee_record

    private

    def create_employee_record
        Employee.create(user_id: self.id, status: true, name: self.name, email: self.email)
    end

    def password_complexity
        return if password.blank?
    
        unless password.match(/\A(?=.*\d)(?=.*[!@#\$%\^&\*])\S{8,}\z/)
          errors.add :password, 'must include at least one special character and one number'
        end
      end
end

class Profile < ApplicationRecord
    has_one :user
    validates :first_name, presence: true
    validates :last_name, presence: true

    def first_name=(value)
        write_attribute :first_name, value.strip
    end

    def last_name=(value)
        write_attribute :last_name, value.strip
    end

    def full_name
        return "#{self.first_name} #{self.last_name}"
    end
end

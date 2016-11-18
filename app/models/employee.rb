class Employee < ApplicationRecord
    validates :first_name,  presence: true
    validates :last_name,  presence: true
    validates :initials,  presence: true
    validates :date_of_birth,  presence: true
    
    def self.search_name(search)
	  where("first_name LIKE ? OR last_name LIKE ?", "%#{search}%", "%#{search}%")
	end
    
    def full_name
       full_name = self.last_name + ", " + self.first_name
    end
end

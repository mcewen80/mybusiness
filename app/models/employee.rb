# Validates if the specified value is a valid
# Burgerservicenummer (Dutch social security number)
class BsnValidator < ActiveModel::Validator
  def validate(employee)
    unless self.class.validate_bsn(employee.bsn)
     employee.errors[:base] << "Unvalid BSN"
    end
  end

  # A BSN is an 8 or 9 digit Dutch social security
  # number.
  def self.validate_bsn(value)
    bsn = value.to_s.gsub(/\D/, '').strip

    # Only allow 8 or 9 digits
    return false if bsn.length < 8 || bsn.length > 9

    # Validate with the advanced eleven test
    self.validate_with_advanced_eleven_test(bsn)
  end

  private

  # Performs the advanced 11-test on a
  # 8 or 9 digit account number
  #
  #  For 9 digits (prefix with a 0 for 8 digits):
  #
  #   123456782
  #   ABCDEFGHI
  #
  #   sum = 9*A + 8*B + 7*C + 6*D + 5*E + 4*F + 3*G + 2*H + -1*I
  #
  # Note the -1*I!
  #
  # If sum % 11 is 0, the number is valid, otherwise
  # a typo has been made or the number is outright invalid.
  def self.validate_with_advanced_eleven_test(number)
    # Make sure we have 9 digits
    number = "0#{number}" if number.size == 8

    numbers = number.split("").map(&:to_i).reverse

    sum = 0
    numbers.each_with_index do |digit, i|
      # The first digit is * -1, the rest
      # counts from 2 up.
      i = i == 0 ? -1 : i+1
      sum += digit * i
    end

    sum % 11 == 0
  end
end


class Employee < ApplicationRecord
    validates :first_name,  presence: true
    validates :last_name,  presence: true
    validates :initials,  presence: true
    validates :date_of_birth,  presence: true
    validates_with BsnValidator
    
    has_many :contracts
    
    # scope
    def self.search_name(search)
	  where("first_name LIKE ? OR last_name LIKE ?", "%#{search}%", "%#{search}%")
	end
    
    # full name definition
    def full_name
       full_name = self.last_name + ", " + self.first_name
    end
    
    def started_working
       @contract = self.contracts.order(start_date: 'ASC').first
       started_working = @contract.start_date 
    end
    
    def active
       @contract = self.contracts.order(start_date: 'DESC').first
       active = @contract.end_date == nil or @contract.end_date >= Date.today
       #active = @contract.end_date >= Date.today
    end
    
    self.per_page = 2
end

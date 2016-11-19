class StartdateBeforeEnddate < ActiveModel::Validator
    def validate(contract)
        if contract.end_date != nil and contract.end_date <= contract.start_date
           contract.errors[:base] << "End date must be later than start date"
        end
    end
end

class Contract < ApplicationRecord
    belongs_to :employee
    
    validates :start_date,  presence: true
    validates :function,  presence: true
    validates_with StartdateBeforeEnddate
end

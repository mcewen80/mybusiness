class Project < ApplicationRecord
    belongs_to :employee
    alias_attribute :manager, :employee
end

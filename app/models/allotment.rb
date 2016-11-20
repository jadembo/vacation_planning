class Allotment < ActiveRecord::Base
    validates :date,              :presence => true,
                                  :uniqueness => {:scope => [:role_id, :department_id]}
    validates :days_available,    :numericality => {:greater_than_or_equal_to => 0, :only_integer => true}
    validates :role_id,           :presence => true
    validates :department_id,     :presence => true

    belongs_to(:department)
    belongs_to(:role)
    has_many(:requests)
end

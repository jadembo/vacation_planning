class Department < ActiveRecord::Base
  validates :department_name,       :presence => true,
                              :uniqueness => true
  has_many(:users)
  has_many(:allotments)
end

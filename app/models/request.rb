class Request < ActiveRecord::Base
  validates :user_id,     :presence => true,
                          :uniqueness => {:scope=> :allotment_id}
  validates :allotment_id,:presence => true
  validates :length,      :presence => true
  validates :request_type,        :presence => true

  belongs_to(:user)
  belongs_to(:allotment)

end

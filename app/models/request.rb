class Request < ActiveRecord::Base
  validates :user_id,     :presence => true,
                          :uniqueness => {:scope=> :allotment_id}
  validates :date_id,     :presence => true
  validates :length,      :presence => true
  validates :type,        :presence => true

  belongs_to(:user)
  belogns_to(:allotment)

end

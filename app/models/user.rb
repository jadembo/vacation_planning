class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 validates :username,      :presence => true,
                           :uniqueness => true
 validates :first_name,    :presence => true
 validates :last_name,     :presence => true
 validates :role_id,       :presence => true
 validates :department_id, :presence=> true

 has_many(:requests)
 belongs_to(:role)
 belongs_to(:department)
end

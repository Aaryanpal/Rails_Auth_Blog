class UserToken < ApplicationRecord
    belongs_to :user
	validates_uniqueness_of :token
	validates_presence_of :token
end

class Cheer < ApplicationRecord
  belongs_to :user
  validates :user_id,presence:true,:uniqueness => {:scope => :recipient_id}
  validates :recipient_id,presence:true
end

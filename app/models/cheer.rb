class Cheer < ApplicationRecord
  belongs_to :users
  validates :user_id,presence:true
  validates :recipient_id,presence:true
end

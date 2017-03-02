class User < ApplicationRecord
  has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable,:omniauthable,omniauth_providers: [:twitter]
  has_many :cheers
  mount_uploader :image, ImageUploader
end

class User < ApplicationRecord
  is_impressionable
  has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable,:omniauthable,omniauth_providers: [:twitter]
  has_many :cheers
  mount_uploader :image, ImageUploader

  before_save :delete_url

  def delete_url
    self.twitter.gsub!("https://twitter.com/","")
    self.instagram.gsub!("https://www.instagram.com/","")
  end

  validates :nickname,presence:true

  # 許可するカラムの名前をオーバーライドする
  def self.ransackable_attributes auth_object = nil
    %w(nickname university department like_subject dislike_subject activity age gender comment)
  end

end

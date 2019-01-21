class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :image, ImageUploader
  has_many :senders
  has_many :recipients
  belongs_to :role
  has_many :posts
  has_many :applications
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

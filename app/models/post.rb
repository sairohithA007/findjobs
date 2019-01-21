class Post < ApplicationRecord
  belongs_to :job
  belongs_to :category
  belongs_to :user
  has_many :applications
end

class Post < ApplicationRecord
  belongs_to :user
  # has_many :likes
  has_many :comments, dependent: :destroy
  has_one_attached :photo, dependent: :destroy
end

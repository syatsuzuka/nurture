class PostBoard < ApplicationRecord

  has_many :posts, dependent: :destroy

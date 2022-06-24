class Post < ApplicationRecord
  belongs_to :user
  # has_many :likes
  has_many :comments, dependent: :destroy
  has_one_attached :photo, dependent: :destroy

  validates :title, :content, presence: true
  validates :title, presence: true, length: { in: 6...70 }
  validates :content, presence: true, length: { in: 30...3000 }
end

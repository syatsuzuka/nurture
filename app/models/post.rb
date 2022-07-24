class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable
  has_one_attached :photo, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_knowledge,
                  against: %i[title content],
                  using: {
                    tsearch: { prefix: true }
                  }
  validates :title, :summary, :content, presence: true
  validates :title, length: { in: 6...70 }
  validates :content, length: { in: 30...3000 }
end

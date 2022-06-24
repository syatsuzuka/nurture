class Post < ApplicationRecord
  belongs_to :user
  # has_many :likes
  has_many :comments, dependent: :destroy
  has_one_attached :photo, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_knowledge,
                  against: %i[title content],
                  using: {
                    tsearch: { prefix: true }
                  }
end

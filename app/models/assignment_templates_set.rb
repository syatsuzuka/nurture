class AssignmentTemplatesSet < ApplicationRecord
  has_many :assignment_templates, dependent: :destroy
  belongs_to :user
  validates :name, :category, presence: true
  validates :name, uniqueness: { scope: :user_id }

  include PgSearch::Model
  pg_search_scope :search,
                  against: %i[name category],
                  using: {
                    tsearch: { prefix: true }
                  }
end

class AssignmentTemplatesSet < ApplicationRecord
  has_many :assignment_templates, dependent: :destroy
  belongs_to :user
  validates :name, :category, presence: true
  validates :name, uniqueness: { scope: :user_id }
end

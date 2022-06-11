class Target < ApplicationRecord
  has_many :progresses, dependent: :destroy
  has_many :targets, foreign_key: :parent_id
  belongs_to :course
  belongs_to :parent, class_name: 'Target', foreign_key: :parent_id, optional: true
  validates :name, uniqueness: { scope: :course_id }, presence: true
  validates :description, :score, presence: true
end

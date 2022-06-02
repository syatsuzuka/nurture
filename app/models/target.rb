class Target < ApplicationRecord
  has_many :progresses, dependent: :destroy
  belongs_to :course
  validates :name, uniqueness: { scope: :course_id }, presence: true
  validates :description, :score, presence: true
end

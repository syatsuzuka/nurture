class AssignmentTemplate < ApplicationRecord
  belongs_to :assignment_templates_sets
  validates :name, :description, :score, presence: true
end

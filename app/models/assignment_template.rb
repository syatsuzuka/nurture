class AssignmentTemplate < ApplicationRecord
  belongs_to :assignment_templates_set
  validates :title, :instruction, :checkpoint, presence: true
  validates :title, uniqueness: { scope: :assignment_templates_set_id }
end

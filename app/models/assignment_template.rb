class AssignmentTemplate < ApplicationRecord
  belongs_to :assignment_templates_set
  validates :title, :instruction, :checkpoint, presence: true
  validates :title, uniqueness: { scope: :assignment_templates_set_id }

  def self.import(file, assignment_templates_set)
    CSV.foreach(file.path, headers: true) do |row|
      assignment_template = new
      assignment_template.title = row["title"]
      assignment_template.instruction = row["instruction"]
      assignment_template.instruction_url = row["instruction_url"]
      assignment_template.checkpoint = row["checkpoint"]
      assignment_template.assignment_templates_set = assignment_templates_set
      assignment_template.save
    end
  end
end

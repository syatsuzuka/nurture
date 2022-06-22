class TargetTemplate < ApplicationRecord
  belongs_to :target_templates_set
  validates :name, :description, :score, presence: true
  validates :name, uniqueness: { scope: :target_templates_set_id }

  def self.import(file, target_templates_set)
    CSV.foreach(file.path, headers: true) do |row|
      target_template = new
      target_template.name = row["name"]
      target_template.description = row["description"]
      target_template.score = row["score"]
      target_template.target_templates_set = target_templates_set
      target_template.save
    end
  end
end

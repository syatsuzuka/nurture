class TargetTemplate < ApplicationRecord
  has_many :target_templates, foreign_key: :parent_id, dependent: :destroy
  belongs_to :target_templates_set
  belongs_to :parent, class_name: 'TargetTemplate', foreign_key: :parent_id, optional: true
  validates :name, :description, :score, presence: true
  validates :name, uniqueness: { scope: :target_templates_set_id }

  def self.import(file, target_templates_set)
    CSV.foreach(file.path, headers: true) do |row|
      target_template = new
      target_template.name = row["name"]
      target_template.description = row["description"]
      target_template.parent = TargetTemplate.find_by(
        name: row["parent"],
        target_templates_set_id: target_templates_set.id
      )
      target_template.score = row["score"]
      target_template.target_templates_set = target_templates_set
      unless target_template.save
        logger.debug("ERROR: Failed in uploading target_template data")
        logger.debug("ERROR: #{target_template.errors.full_messages}")
      end
    end
  end
end

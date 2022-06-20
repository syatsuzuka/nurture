class TargetTemplate < ApplicationRecord
  belongs_to :target_templates_sets
  validates :name, :description, :score, presence: true
end

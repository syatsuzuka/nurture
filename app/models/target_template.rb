class TargetTemplate < ApplicationRecord
  belongs_to :target_templates_set
  validates :name, :description, :score, presence: true
  validates :name, uniqueness: { scope: :target_templates_set_id }
end

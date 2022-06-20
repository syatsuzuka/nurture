class TargetTemplatesSet < ApplicationRecord
  has_many :target_templates, dependent: :destroy
  belongs_to :user
  validates :name, :category, presence: true
end

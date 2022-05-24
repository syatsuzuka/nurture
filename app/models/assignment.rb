class Assignment < ApplicationRecord
  validates :title, :instruction, :comment, :checkpoint, presence: true
  belongs_to :course
end

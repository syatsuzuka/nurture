class Target < ApplicationRecord
  has_many :progresses
  belongs_to :course
end

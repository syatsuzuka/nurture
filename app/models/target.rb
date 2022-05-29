class Target < ApplicationRecord
  has_many :progresses, dependent: :destroy
  belongs_to :course
end

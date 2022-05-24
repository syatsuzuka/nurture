class Course < ApplicationRecord
  belongs_to :tutor
  belongs_to :student
  has_many :assignments, dependent: :destroy
end

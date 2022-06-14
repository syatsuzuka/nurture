class Review < ApplicationRecord
  belongs_to :tutor, class_name: "User"
  belongs_to :student, class_name: "User"
  validates :tutor, uniqueness: { scope: :student }
end

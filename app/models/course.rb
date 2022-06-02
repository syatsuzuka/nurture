class Course < ApplicationRecord
  belongs_to :tutor, :class_name => "User", :foreign_key => :tutor_user_id
  belongs_to :student, :class_name => "User", :foreign_key => :student_user_id
  has_many :assignments, dependent: :destroy
  has_many :targets, dependent: :destroy
  validates :name, :description, presence: true
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true }
    }
end

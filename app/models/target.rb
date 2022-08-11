class Target < ApplicationRecord
  has_many :progresses, dependent: :destroy
  has_many :targets, foreign_key: :parent_id, dependent: :destroy
  # has_many :assignments_targets, dependent: :destroy
  # has_many :assignments, through: :assignments_targets
  has_many :assignments
  belongs_to :course
  belongs_to :parent, class_name: 'Target', foreign_key: :parent_id, optional: true
  validates :name, uniqueness: { scope: :course_id }, presence: true
  validates :description, :score, presence: true
  validate :check_score

  include PgSearch::Model
  pg_search_scope :search,
                  against: %i[name],
                  using: {
                    tsearch: { prefix: true }
                  }

  def self.import(file, course)
    CSV.foreach(file.path, headers: true) do |row|
      target = new
      target.name = row["name"]
      target.description = row["description"]
      target.parent = Target.find_by(name: row["parent"], course_id: course.id)
      target.score = row["score"]
      target.score_type = row["score_type"]
      target.display = row["display"]
      target.course = course
      unless target.save
        logger.debug("ERROR: Failed in uploading target data")
        logger.debug("ERROR: #{target.errors.full_messages}")
      end
    end
  end

  def check_score
    case score_type
    when "boolean"
      errors.add(:score, " needs to be a boolean") unless score.in?([0, 1])
    when "integer"
      errors.add(:score, " needs to be an integer") unless score == score.floor
    end
  end
end

class Progress < ApplicationRecord
  belongs_to :target
  validates :date, :score, presence: true
  validate :check_score

  def self.import(file, target)
    CSV.foreach(file.path, headers: true) do |row|
      progress = new
      progress.date = row["date"]
      progress.score = row["score"]
      progress.comment = row["comment"]
      progress.target = target
      unless progress.save
        logger.debug("ERROR: Failed in uploading progress data")
        logger.debug("ERROR: #{progress.errors.full_messages}")
      end
    end
  end

  def check_score
    case target.score_type
    when "boolean"
      errors.add(:score, " needs to be a boolean") unless score.in?([0, 1])
    when "integer"
      errors.add(:score, " needs to be an integer") unless score == score.floor
    end
  end
end

class Progress < ApplicationRecord
  belongs_to :target
  validate :check_date
  validate :check_score

  def self.to_csv
    attributes = %w[date score]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |progress|
        csv << attributes.map{ |attr| progress.send(attr) }
      end
    end
  end

  def check_date
    errors.add(:date, "is required") if date.blank?
  end

  def check_score
    errors.add(:score, "is required") if score.blank?
  end
end

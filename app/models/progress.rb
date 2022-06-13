class Progress < ApplicationRecord
  belongs_to :target
  validates :date, :score, presence: true

  def self.import(file, target)
    CSV.foreach(file.path, headers: true) do |row|
      progress = new
      progress.date = row["date"]
      progress.score = row["score"]
      progress.comment = row["comment"]
      progress.target = target
      progress.save
    end
  end

  def self.to_csv
    attributes = %w[date score]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |progress|
        csv << attributes.map { |attr| progress.send(attr) }
      end
    end
  end
end

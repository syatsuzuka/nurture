class Progress < ApplicationRecord
  belongs_to :target
  validates :date, :score, presence: true

  def self.to_csv
    attributes = %w[date score]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |progress|
        csv << attributes.map{ |attr| progress.send(attr) }
      end
    end
  end
end

class Target < ApplicationRecord
  has_many :progresses, dependent: :destroy
  has_many :targets, foreign_key: :parent_id, dependent: :destroy
  belongs_to :course
  belongs_to :parent, class_name: 'Target', foreign_key: :parent_id, optional: true
  validates :name, uniqueness: { scope: :course_id }, presence: true
  validates :description, :score, presence: true

  def self.import(file, course)
    CSV.foreach(file.path, headers: true) do |row|
      target = new
      target.name = row["name"]
      target.description = row["description"]
      if row["parent"].blank?
        target.fullpath = "/ #{target.name}"
      else
        target.parent = Target.find_by(name: row["parent"])
        target.fullpath = "#{target.parent.fullpath} / #{target.name}"
      end
      target.score = row["score"]
      target.display = row["display"]
      target.course = course
      target.save
    end
  end
end

class Assignment < ApplicationRecord
  # has_many :assignments_targets, dependent: :destroy
  # has_many :targets, through: :assignments_targets
  # accepts_nested_attributes_for :assignments_targets, allow_destroy: true
  belongs_to :target, optional: true
  belongs_to :course
  has_one_attached :instruction_video
  has_one_attached :material_video
  delegate :tutor, to: :course
  delegate :student, to: :course
  validates :title, uniqueness: { scope: :course_id }, presence: true
  validates :instruction, :checkpoint, :status, presence: true
  validate :check_instruction_url
  validate :check_material_url

  def check_instruction_url
    unless instruction_url.blank?
      unless instruction_url =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
        errors.add(:instruction_url, "need to be a valid URL")
      end
    end
  end

  def check_material_url
    unless material_url.blank?
      unless material_url =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
        errors.add(:material_url, "need to be a valid URL")
      end
    end
  end

  def self.import(file, course)
    CSV.foreach(file.path, headers: true) do |row|
      target = Target.find_by(course: course, name: row["target"])
      assignment = new
      assignment.title = row["title"]
      assignment.target = target
      assignment.instruction = row["instruction"]
      assignment.instruction_url = row["instruction_url"]
      assignment.checkpoint = row["checkpoint"]
      assignment.status = 0
      assignment.start_date = row["start_date"]
      assignment.end_date = row["end_date"]
      assignment.course = course
      unless assignment.save
        logger.debug("ERROR: Failed in uploading assignment data")
        logger.debug("ERROR: #{assignment.errors.full_messages}")
      end
    end
  end
end

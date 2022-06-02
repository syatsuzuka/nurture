class Assignment < ApplicationRecord
  belongs_to :course
  validates :title, uniqueness: { scope: :course_id }
  validates :instruction, :checkpoint, presence: true
  validate :check_status
  validate :check_instruction_url
  validate :check_material_url
  # validates :instruction_url, format: /\A#{URI::regexp(%w(http https))}\z/
  # validates :material_url, format: /\A#{URI::regexp(%w(http https))}\z/

  def check_instruction_url
    unless instruction_url.blank?
      errors.add(:instruction_url, "need to be a valid URL") unless instruction_url =~ /\A#{URI::regexp(%w(http https))}\z/
    end
  end

  def check_material_url
    unless material_url.blank?
      errors.add(:material_url, "need to be a valid URL") unless material_url =~ /\A#{URI::regexp(%w(http https))}\z/
    end
  end

  def check_checkpoint
    errors.add(:checkpoint, "can't be blank") if checkpoint.blank?
  end

  def check_status
    errors.add(:status, "can't be blank") if status.blank?
  end
end

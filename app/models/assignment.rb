class Assignment < ApplicationRecord
  belongs_to :course
  validates :title, uniqueness: { scope: :course_id }, presence: true
  validates :instruction, :checkpoint, :status, :start_date, :end_date, presence: true
  validate :check_instruction_url
  validate :check_material_url

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
end

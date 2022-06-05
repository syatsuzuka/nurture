class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tutor_users, :class_name => "Course", :foreign_key => :tutor_user_id
  has_many :student_users, :class_name => "Course", :foreign_key => :student_user_team_id
  has_many :messages, dependent: :destroy
  has_one_attached :photo
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :nickname, uniqueness: true, presence: true
  validate :check_role
  after_create :send_welcome_email
  after_update :send_update_email

  def active_for_authentication?
    super && !deactivated
  end

  def select_label
    "#{first_name} #{last_name} <#{email}>"
  end

  def check_role
    errors.add(:role, "Role should be 'tutor' or 'student'") unless ["admin", "tutor", "student"].include?(role)
  end

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_now
  end

  def send_update_email
    # UserMailer.with(user: self).update_email.deliver_now
  end
end

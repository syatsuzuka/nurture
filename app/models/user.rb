class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tutor_users, class_name: "Course", foreign_key: :tutor_user_id
  has_many :student_users, class_name: "Course", foreign_key: :student_user_team_id
  has_many :tutor_reviews, class_name: "Review", foreign_key: :tutor_id, dependent: :destroy
  has_many :student_reviews, class_name: "Review", foreign_key: :student_id, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :target_templates_sets, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :users, foreign_key: :manager_id, dependent: :destroy
  has_one_attached :photo
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id, optional: true
  validates :first_name, presence: true, length: { minimum: 1, maximum: 60 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 60 }
  validates :nickname, uniqueness: true, presence: true, length: { maximum: 60 }
  validates :email, length: { maximum: 254 }
  validate :check_role
  after_create :send_welcome_email
  after_create :create_sample_course
  before_update :send_update_email

  include PgSearch::Model
  pg_search_scope :search,
                  against: %i[first_name last_name nickname email interest specialty],
                  using: {
                    tsearch: { prefix: true }
                  }

  def active_for_authentication?
    super && !deactivated
  end

  def select_label_nickname
    nickname
  end

  def select_label_fullname
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def check_role
    errors.add(:role, "Role should be 'tutor' or 'student'") unless ["admin", "tutor", "student"].include?(role)
  end

  private

  def create_sample_course
    if role == "tutor" && email != ENV.fetch('SAMPLE_TUTOR_LOGIN_ID')
      course = Course.create!(
        name: "Sample Course (Tennis Lesson)",
        description: "This is a sample course. Please feel free to use this as a sandbox environment.",
        status: 1,
        tutor: self,
        student: User.find_by(email: ENV.fetch('SAMPLE_STUDENT_LOGIN_ID'))
      )
      add_sample_data(course)

    elsif role == "student" && email != ENV.fetch('SAMPLE_STUDENT_LOGIN_ID')
      course = Course.create!(
        name: "Sample Course (Tennis Lesson)",
        description: "This is a sample course. Please feel free to use this as a sandbox environment.",
        status: 1,
        tutor: User.find_by(email: ENV.fetch('SAMPLE_TUTOR_LOGIN_ID')),
        student: self
      )
      add_sample_data(course)
    end
  end

  def send_welcome_email
    if Rails.env.production?
      UserMailer.with(user: self).welcome_email.deliver_later
    else
      UserMailer.with(user: self).welcome_email.deliver_now
    end
  end

  def send_update_email
    if has_changes_to_save?
      if Rails.env.production?
        UserMailer.with(user: self).update_email.deliver_later
      else
        UserMailer.with(user: self).update_email.deliver_now
      end
    end
  end

  def add_sample_data(course)
    Chatroom.create!(name: "Assignment chat")
    Assignment.create!(
      title: "Swing Practice every day",
      instruction: "Take 30mins for shadow swing everyday",
      comment: "", checkpoint: "Take 30mins for shadow swing almost everyday (more than 90%)",
      course_id: course.id,
      status: 0,
      start_date: "2020-09-01", end_date: "2020-12-31"
    )
    target1 = Target.create!(
      name: "Forhand Stroke (%)",
      description: "Achieve higher successful rate in Forehand Stroke.",
      score: 40,
      display: true,
      course_id: course.id,
      parent_id: nil
    )
    target2 = Target.create!(
      name: "Backhand Stroke (%)",
      description: "Achieve higher successful rate in Backhand Stroke.",
      score: 20,
      display: true,
      course_id: course.id,
      parent_id: nil
    )
    Progress.create!(
      date: "2020-04-01",
      score: target1.score - 2.0 + rand(8) - 4,
      target_id: target1.id,
      comment: "the score in official game with M
      ike of ABC junior high school"
    )
    Progress.create!(
      date: "2020-05-01",
      score: target1.score - 1.5 + rand(8) - 4,
      target_id: target1.id,
      comment: "the score in private game with Jo
      hn of the same junior high school"
    )
    Progress.create!(
      date: "2020-06-01",
      score: target1.score - 1.0 + rand(8) - 4,
      target_id: target1.id,
      comment: "the score in championship league"
    )
    Progress.create!(
      date: "2020-07-01",
      score: target1.score - 0.5 + rand(8) - 4,
      target_id: target1.id,
      comment: "the score in official game with M
      ike of ABC junior high school"
    )
    Progress.create!(
      date: "2020-08-01",
      score: target1.score + 0.0 + rand(8) - 4,
      target_id: target1.id,
      comment: "the score in private game with Jo
      hn of the same junior high school"
    )
    Progress.create!(
      date: "2020-09-01",
      score: target1.score + 0.5 + rand(8) - 4,
      target_id: target1.id,
      comment: "the score in championship league"
    )
    Progress.create!(
      date: "2020-10-01",
      score: target1.score + 1.0 + rand(8) - 4,
      target_id: target1.id,
      comment: "the score in official game with M
      ike of ABC junior high school"
    )
    Progress.create!(
      date: "2020-11-01",
      score: target1.score + 1.5 + rand(8) - 4,
      target_id: target1.id,
      comment: "the score in private game with Jo
      hn of the same junior high school"
    )
    Progress.create!(
      date: "2020-12-01",
      score: target1.score + 2.0 + rand(8) - 4,
      target_id: target1.id,
      comment: "the score in championship league"
    )

    Progress.create!(
      date: "2020-04-01",
      score: target2.score - 2.0 + rand(8) - 4,
      target_id: target2.id,
      comment: "the score in official game with M
      ike of ABC junior high school"
    )
    Progress.create!(
      date: "2020-05-01",
      score: target2.score - 1.5 + rand(8) - 4,
      target_id: target2.id,
      comment: "the score in private game with Jo
      hn of the same junior high school"
    )
    Progress.create!(
      date: "2020-06-01",
      score: target2.score - 1.0 + rand(8) - 4,
      target_id: target2.id,
      comment: "the score in championship league"
    )
    Progress.create!(
      date: "2020-07-01",
      score: target2.score - 0.5 + rand(8) - 4,
      target_id: target2.id,
      comment: "the score in official game with M
      ike of ABC junior high school"
    )
    Progress.create!(
      date: "2020-08-01",
      score: target2.score + 0.0 + rand(8) - 4,
      target_id: target2.id,
      comment: "the score in private game with Jo
      hn of the same junior high school"
    )
    Progress.create!(
      date: "2020-09-01",
      score: target2.score + 0.5 + rand(8) - 4,
      target_id: target2.id,
      comment: "the score in championship league"
    )
    Progress.create!(
      date: "2020-10-01",
      score: target2.score + 1.0 + rand(8) - 4,
      target_id: target2.id,
      comment: "the score in official game with M
      ike of ABC junior high school"
    )
    Progress.create!(
      date: "2020-11-01",
      score: target2.score + 1.5 + rand(8) - 4,
      target_id: target2.id,
      comment: "the score in private game with Jo
      hn of the same junior high school"
    )
    Progress.create!(
      date: "2020-12-01",
      score: target2.score + 2.0 + rand(8) - 4,
      target_id: target2.id,
      comment: "the score in championship league"
    )
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :created_courses, foreign_key: :user_id, class_name: "Course"
 end

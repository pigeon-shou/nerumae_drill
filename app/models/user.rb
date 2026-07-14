class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :learnings, dependent: :destroy
  has_many :reviews, through: :learnings
  has_many :study_logs, dependent: :destroy

def current_streak
  dates = study_logs.order(studied_on: :desc).pluck(:studied_on)
  return 0 if dates.empty?

  today = Date.current
  return 0 if dates.first < today - 1 # 昨日より前で途切れていたら0

  streak = 0
  expected = dates.first
  dates.each do |date|
    break unless date == expected
    streak += 1
    expected -= 1
  end
  streak
end
  
  # validates :password, format: { with: }
  validates :nickname, presence: true

  # validates sleep_time, presence: true
  # validates line_user_id presence: true
end

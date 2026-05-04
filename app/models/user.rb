class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :learnings, dependent: :destroy
  has_many :reviews, through: :learnings
  
  # validates :password, format: { with: }
  validates :nickname, presence: true

  # validates sleep_time, presence: true
  # validates line_user_id presence: true
end

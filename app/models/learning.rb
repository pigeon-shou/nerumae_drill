class Learning < ApplicationRecord
  belongs_to :user
  # has_many :reviews, dependet: :destroy

  validates :content, presence: true
  
end

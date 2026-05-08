class Review < ApplicationRecord
  # このモデルでAH有効化
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :review_type
  belongs_to :learning
  
  with_options presence: true do
  validates :status
  validates :scheduled_at
  validates :review_type_id
  end
  
  enum status: {
  waiting: 0,
  completed: 1
}
end
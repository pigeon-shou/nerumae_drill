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

  validates :review_type_id, numericality: { other_than: 1, message: 'を選択してください' }
  
  enum status: {
  waiting: 0,
  completed: 1
}
end
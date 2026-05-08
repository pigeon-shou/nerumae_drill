class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer    :status,           null: false, default: 0
      t.integer    :review_type_id,   null: false
      t.datetime   :scheduled_at,     null: false
      t.references :learning,         null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateLearnings < ActiveRecord::Migration[7.1]
  def change
    create_table :learnings do |t|
      t.string :content, null: false
      t.string :keyword
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateStudyLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :study_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.date :studied_on, null: false
      t.timestamps
    end
    add_index :study_logs, [:user_id, :studied_on], unique: true
  end
end
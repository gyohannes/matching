class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.references :exam, foreign_key: true
      t.references :program, foreign_key: true
      t.float :result

      t.timestamps
    end
  end
end

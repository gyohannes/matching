class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.float :aptitude_weight
      t.float :interview_weight
      t.float :exam_weight

      t.timestamps
    end
  end
end

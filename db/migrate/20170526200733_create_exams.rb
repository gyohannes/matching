class CreateExams < ActiveRecord::Migration[5.1]
  def change
    create_table :exams do |t|
      t.references :applicant, foreign_key: true
      t.float :aptitude_exam_result
      t.float :interview_result

      t.timestamps
    end
  end
end

class RemoveInterviewResultFromExams < ActiveRecord::Migration[5.1]
  def change
	remove_column :exams, :interview_result
  end
end

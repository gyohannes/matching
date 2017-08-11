class AddInterviewResultToExams < ActiveRecord::Migration[5.1]
  def change
  	add_column :exams, :interview_result, :float
  end
end

class DeleteDateOfBirthFromApplicants < ActiveRecord::Migration[5.1]
  def change
    remove_column :applicants, :date_of_birth
  end
end

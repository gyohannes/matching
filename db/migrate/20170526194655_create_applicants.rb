class CreateApplicants < ActiveRecord::Migration[5.1]
  def change
    create_table :applicants do |t|
      t.string :first_name
      t.string :father_name
      t.string :grand_father_name
      t.string :gender
      t.string :email
      t.date :date_of_birth

      t.timestamps
    end
  end
end

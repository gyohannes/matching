class CreateProgramChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :program_choices do |t|
      t.references :applicant, foreign_key: true
      t.references :program, foreign_key: true
      t.integer :choice_number

      t.timestamps
    end
  end
end

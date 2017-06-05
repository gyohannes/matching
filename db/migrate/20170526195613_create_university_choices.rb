class CreateUniversityChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :university_choices do |t|
      t.references :program_choice, foreign_key: true
      t.references :university, foreign_key: true
      t.integer :choice_number

      t.timestamps
    end
  end
end

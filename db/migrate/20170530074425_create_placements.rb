class CreatePlacements < ActiveRecord::Migration[5.1]
  def change
    create_table :placements do |t|
      t.references :applicant, foreign_key: true
      t.references :program, foreign_key: true
      t.references :university, foreign_key: true

      t.timestamps
    end
  end
end

class CreateProgramQuota < ActiveRecord::Migration[5.1]
  def change
    create_table :program_quota do |t|
      t.references :program, foreign_key: true
      t.references :university, foreign_key: true
      t.integer :quota_number

      t.timestamps
    end
  end
end

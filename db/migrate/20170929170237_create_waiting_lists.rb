class CreateWaitingLists < ActiveRecord::Migration[5.1]
  def change
    create_table :waiting_lists do |t|
      t.references :applicant, foreign_key: true
      t.references :program, foreign_key: true
      t.references :university, foreign_key:

      t.timestamps
    end
  end
end

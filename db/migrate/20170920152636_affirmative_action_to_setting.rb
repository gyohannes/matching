class AffirmativeActionToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :affirmative_percentage, :float
  end
end

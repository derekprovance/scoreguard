class FixMissedColumnName < ActiveRecord::Migration
  def change
    rename_column :goals, :missed, :attended
    change_column :goals, :attended, :boolean, :default => false
  end
end

class ChangeGoalToDate < ActiveRecord::Migration
  def change
    change_column :goals, :starts_at, :Date
  end
end

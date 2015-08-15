class AddEarnedTotalCalendarPoints < ActiveRecord::Migration
  def change
    remove_column :grades, :calendar_points, :integer
    add_column :grades, :calendar_earned_points, :integer
    add_column :grades, :calendar_total_points, :integer
  end
end

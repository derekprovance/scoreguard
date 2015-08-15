class AddMiscToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :misc_earned_points, :integer
    add_column :grades, :misc_total_points, :integer
  end
end

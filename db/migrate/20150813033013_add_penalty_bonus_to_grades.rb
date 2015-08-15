class AddPenaltyBonusToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :bonus_points, :integer
    add_column :grades, :penalty_points, :integer
  end
end

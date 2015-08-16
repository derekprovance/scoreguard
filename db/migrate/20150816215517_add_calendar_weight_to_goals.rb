class AddCalendarWeightToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :weight, :integer
  end
end

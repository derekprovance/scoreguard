class AddDefaultValueGoals < ActiveRecord::Migration
  def change
    change_column :goals, :missed, :boolean, :default => true
  end
end

class AddRepeatToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :repeat, :boolean, :default => false
  end
end

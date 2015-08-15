class AddMissedEventToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :missed, :boolean
  end
end

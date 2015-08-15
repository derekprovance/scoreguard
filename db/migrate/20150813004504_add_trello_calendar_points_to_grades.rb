class AddTrelloCalendarPointsToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :trello_points, :integer
    add_column :grades, :calendar_points, :integer
  end
end

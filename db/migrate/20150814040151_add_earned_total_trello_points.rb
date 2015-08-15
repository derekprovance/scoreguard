class AddEarnedTotalTrelloPoints < ActiveRecord::Migration
  def change
    remove_column :grades, :trello_points, :integer
    add_column :grades, :trello_earned_points, :integer
    add_column :grades, :trello_total_points, :integer
  end
end

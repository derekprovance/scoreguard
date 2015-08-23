class CleanUpGrades < ActiveRecord::Migration
  def change
    remove_column :grades, :score, :string
    remove_column :grades, :goal, :integer
    remove_column :grades, :comments, :string

    add_column :grades, :misc_tasks, :json
  end
end

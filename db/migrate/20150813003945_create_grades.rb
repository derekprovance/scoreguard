class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.date :created_on
      t.decimal :score
      t.integer :goal
      t.integer :earned_points
      t.integer :total_points
      t.string :comments

      t.timestamps null: false
    end
  end
end

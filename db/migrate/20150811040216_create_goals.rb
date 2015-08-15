class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name
      t.datetime :starts_at

      t.timestamps null: false
    end
  end
end

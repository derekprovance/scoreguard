class MiscTask < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :actual_points, presence: true
  validates :total_points, presence: true
end

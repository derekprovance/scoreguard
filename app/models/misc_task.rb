class MiscTask < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :user

  validates :name, presence: true
  validates :actual_points, presence: true
  validates :total_points, presence: true
end

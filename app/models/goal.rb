class Goal < ActiveRecord::Base
  include ApplicationHelper
  extend SimpleCalendar
  has_calendar

  validates :name, presence: true
  validates :weight, presence: true
  validates :starts_at, presence: true
end

require 'trello'
require 'google_calendar'

class MainController < ApplicationController
  def index
    @gpa = GpaCalculator.new

    @trello_percentage = get_trello_percentage
    @calendar_percentage = get_calendar_percentage
    @misc_task_percentage = get_misc_task_percentage
  end

  def get_trello_percentage
    format_nan_zero(((@gpa.trello_earned_points / @gpa.trello_total_points.to_f) * 100).round(2))
  end

  def get_calendar_percentage
    format_nan_zero(((@gpa.calendar_earned_points / @gpa.calendar_total_points.to_f) * 100).round(2))
  end

  def get_misc_task_percentage
    format_nan_zero(((@gpa.misc_tasks.earned_misc_points / @gpa.misc_tasks.total_misc_points.to_f) * 100).round(2))

  end

  def format_nan_zero(percentage)
    percentage.nan? ? 0 : percentage
  end

end

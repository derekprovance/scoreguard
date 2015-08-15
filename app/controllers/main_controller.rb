require 'trello'
require 'google_calendar'

class MainController < ApplicationController
  def index
    @gpa = GpaCalculator.new(current_user)
    @misc_tasks = MiscTasksController.new
    @misc_tasks.current = current_user

    @trello_percentage = get_trello_percentage
    @calendar_percentage = get_calendar_percentage
    @misc_task_percentage = get_misc_task_percentage
  end

  def get_trello_percentage
    format_nan_zero(((@gpa.current_grade.trello_earned_points / @gpa.current_grade.trello_total_points.to_f) * 100).round(2))
  end

  def get_calendar_percentage
    format_nan_zero(((@gpa.current_grade.calendar_earned_points / @gpa.current_grade.calendar_total_points.to_f) * 100).round(2))
  end

  def get_misc_task_percentage
    format_nan_zero(((@misc_tasks.earned_misc_points / @misc_tasks.total_misc_points.to_f) * 100).round(2))
  end

  def format_nan_zero(percentage)
    percentage.nan? ? 0 : percentage
  end

end

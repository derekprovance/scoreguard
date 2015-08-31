class AnalyticsController < ApplicationController
  def index
    @gpa = GpaCalculator.new(current_user)
    @goals = Goal.where(user_id: current_user.id).to_a

    @misc_tasks = MiscTasksController.new
    @misc_tasks.current = current_user

    @trello_percentage = get_trello_percentage
    @calendar_percentage = get_calendar_percentage
    @misc_task_percentage = get_misc_task_percentage

    populate_total_analytics
  end

  def populate_total_analytics(date_range = Time.now.in_time_zone(current_user.time_zone)-5.day..Time.now.in_time_zone(user.time_zone))
    grade = Grade.where(user_id: current_user.id).where(created_on: date_range)
    @grade_analytics = {}
    @grade_analytics['Total Points'] = grade.group_by_day(:created_at).sum(:total_points)
    @grade_analytics['Earned Points'] = grade.group_by_day(:created_at).sum(:earned_points)
  end

  def get_trello_percentage
    format_nan_zero(((@gpa.current_grade.trello_earned_points / @gpa.current_grade.trello_total_points.to_f) * 100).round(2))
  end

  def get_calendar_percentage
    format_nan_zero(((@gpa.current_grade.calendar_earned_points / @gpa.current_grade.calendar_total_points.to_f) * 100).round(2))
  end

  def get_misc_task_percentage
    format_nan_zero(((@gpa.current_grade.misc_earned_points / @gpa.current_grade.misc_total_points.to_f) * 100).round(2))
  end

  def format_nan_zero(percentage)
    percentage.nan? ? 0 : percentage
  end
end

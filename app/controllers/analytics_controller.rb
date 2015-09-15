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

  def populate_total_analytics(date_range = Date.current-5.day..Date.current)
    grade = Grade.where(user_id: current_user.id).where(created_on: get_weeks)
    @grade_analytics = {}
    @grade_analytics['Total Points'] = grade.group_by_week(:created_on, format: "%m %d %Y").sum(:total_points)
    @grade_analytics['Earned Points'] = grade.group_by_week(:created_on, format: "%m %d %Y").sum(:earned_points)
  end

  def get_weeks(weeks_prev = 10) 
    count = 0
    weeks = []
    current_week = Date.current.end_of_week
    while (count <= weeks_prev) do 
      weeks.push(current_week - (count*7).days)
      count += 1
    end
    
    weeks
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

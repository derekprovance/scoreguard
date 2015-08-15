class GpaCalculator < ApplicationController

  attr_accessor :total_points, :earned_points, :grade_percentage, :misc_tasks, :current_grade

  def initialize
    @misc_tasks ||= MiscTask.new
    @grades ||= Grade.new

    @current_grade = @grades.obtain_grade_points

    # update_trello
    update_calendar
    # Total Points Calculations
    @total_points = calculate_total_points
    @earned_points = calculate_total_earned_points
    @grade_percentage = calculate_grade_percentage
  end

  def update_trello
    Thread.new do
      @grades.update_trello_points(@grades.obtain_grade_points)
    end
  end

  def update_calendar
    @grades.update_calendar_points(@grades.obtain_grade_points)
  end

  def calculate_total_earned_points
    @current_grade.trello_earned_points + @current_grade.calendar_earned_points + @misc_tasks.earned_misc_points
  end

  def calculate_total_points
    @current_grade.trello_total_points + @current_grade.calendar_total_points + @misc_tasks.total_misc_points
  end

  def calculate_grade_percentage
    ((calculate_total_earned_points / calculate_total_points.to_f) * 100).round(2)
  end
end

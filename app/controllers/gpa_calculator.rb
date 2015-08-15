class GpaCalculator < ApplicationController

  attr_accessor :total_points, :earned_points, :grade_percentage, :misc_tasks, :current_grade

  def initialize(current_user)
    @misc_tasks ||= MiscTask.new
    @grades ||= Grade.new

    # TODO - need to remove these assignments below. The assignments are shameful and need replaced
    @misc_tasks.current_user = current_user
    @grades.current_user = current_user

    @current_grade = @grades.obtain_grade_points

    # TODO - need to find a way to passively update trello without a massive amount of spamming
    # TODO - need to remove or clean up all of these variable assignments
    # update_trello
    update_calendar
    # Total Points Calculations
    @total_points = calculate_total_points
    @earned_points = calculate_total_earned_points
    @grade_percentage = calculate_grade_percentage
  end

  def create
    @grades = Grade.new(grade_params)
    @grades.user_id = current_user.id

    respond_to do |format|
      if @grades.save
        format.html { redirect_to @grades, notice: 'Goal was successfully created.' }
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new }
        format.json { render json: @grades.errors, status: :unprocessable_entity }
      end
    end
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

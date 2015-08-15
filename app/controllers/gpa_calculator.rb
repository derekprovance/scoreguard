class GpaCalculator < ApplicationController

  attr_accessor :total_points, :earned_points, :grade_percentage, :current_grade

  def initialize(current_user)
    @grades ||= Grade.new

    @current_grade = @grades.obtain_grade_points(current_user)
    @current_user = current_user

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
    @grades.user_id = @current_user.id

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
      # TODO - Need to setup limit for trello requests
      trello = TrelloApi.new
      @trello_earned_points = trello.get_earned_value
      @trello_total_points = trello.get_total_value

      if @trello_earned_points || @trello_total_points
        current_grade.trello_earned_points = @trello_earned_points
        current_grade.trello_total_points = @trello_total_points
        current_grade.save!
      end
    end
  end

  def update_calendar
    start_date = Date.current.beginning_of_week
    @calendar_earned_points = Goal.where(starts_at: start_date..start_date+7.days).where(missed: false).where(user_id: current_user.id).size
    @calendar_total_points = Goal.where(starts_at: start_date..start_date+7.days).where(user_id: current_user.id).size
    current_grade.calendar_earned_points = @calendar_earned_points
    current_grade.calendar_total_points = @calendar_total_points
    current_grade.save!
  end

  def calculate_total_earned_points
    @current_grade.trello_earned_points + @current_grade.calendar_earned_points + 0
  end

  def calculate_total_points
    @current_grade.trello_total_points + @current_grade.calendar_total_points + 0
  end

  def calculate_grade_percentage
    ((calculate_total_earned_points / calculate_total_points.to_f) * 100).round(2)
  end
end

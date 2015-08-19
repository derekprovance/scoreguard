class GpaCalculator < ApplicationController

  attr_accessor :total_points, :earned_points, :current_grade

  # TODO - Need to store actual points in addition to weighted points

  def initialize(current_user)
    @grades ||= Grade.new

    @current_grade = @grades.obtain_grade_points(current_user)
    @current_user = current_user

    # Update the different APIs
    update_trello
    update_calendar
    update_misc

    # Total Points Calculations
    @total_points = calculate_total_points
    @earned_points = calculate_total_earned_points
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

  def update_trello(force=false)
    # Thread.new do
      trello = Apis::TrelloApi.new(@current_user)

      if update_trello?(trello, force)
        @trello_earned_points = trello.get_earned_value
        @trello_total_points = trello.get_total_value
        trello.get_last_updated = Time.now.in_time_zone("UTC")

        if @trello_earned_points || @trello_total_points
          current_grade.trello_earned_points = @trello_earned_points
          current_grade.trello_total_points = @trello_total_points
          current_grade.save!
        end
      end
    # end
  end

  def update_trello?(api, force)
    return if api.get_last_updated.nil?
    api.get_last_updated + 15.minutes < Time.now.in_time_zone("UTC") || force == true
  end

  def update_calendar
    start_date = Date.current.beginning_of_week
    current_grade.calendar_earned_points = Goal.where(starts_at: start_date..start_date+6.days).where(missed: false).where(user_id: current_user.id).sum(:weight)
    current_grade.calendar_total_points = Goal.where(starts_at: start_date..start_date+6.days).where(user_id: current_user.id).sum(:weight)
    current_grade.save!
  end

  def update_misc
    start_date = Date.current.beginning_of_week
    current_grade.misc_earned_points = MiscTask.where(user_id: current_user.id).map{ |misc| misc.actual_points * misc.weight }.sum
    current_grade.misc_total_points = MiscTask.where(user_id: current_user.id).map{ |misc| misc.total_points * misc.weight }.sum
    current_grade.save!
  end

  def calculate_total_earned_points
    (@current_grade.trello_earned_points + @current_grade.calendar_earned_points + @current_grade.misc_earned_points)
  end

  def calculate_total_points
    @current_grade.trello_total_points + @current_grade.calendar_total_points + @current_grade.misc_total_points
  end

  def calculate_grade_percentage
    ((calculate_total_earned_points / calculate_total_points.to_f) * 100).round(2)
  end
end

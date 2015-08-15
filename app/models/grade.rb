class Grade < ActiveRecord::Base
  def obtain_grade_points
    @current_grades ||= Grade.where(created_on: Date.current).first
    if @current_grades.nil? || @current_grades.created_on != Date.current
      @current_grades = Grade.new(created_on: Date.current, trello_earned_points: 0, trello_total_points: 0, calendar_earned_points: 0, calendar_total_points: 0, earned_points: 0, total_points: 0)
      @current_grades.save!
    end
    @current_grades
  end

  def update_trello_points(current_grade)
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

  def update_calendar_points(current_grade)
    @calendar_earned_points = GoalsController.obtain_events_current_week.where(missed: false).size
    @calendar_total_points = GoalsController.obtain_events_current_week.size
    current_grade.calendar_earned_points = @calendar_earned_points
    current_grade.calendar_total_points = @calendar_total_points
    current_grade.save!
  end
end

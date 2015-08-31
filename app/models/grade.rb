class Grade < ActiveRecord::Base
  belongs_to :user

  def obtain_grade_points(current_user)
    @current_grades ||= Grade.where(created_on: Date.today).where(user_id: current_user.id).first
    if @current_grades.nil? || @current_grades.created_on != Date.today
      @current_grades = Grade.new(user_id: current_user.id, created_on: Date.today, trello_earned_points: 0, trello_total_points: 0, calendar_earned_points: 0, calendar_total_points: 0, earned_points: 0, total_points: 0)
      @current_grades.save!
    end
    @current_grades
  end
end

class Grade < ActiveRecord::Base
  belongs_to :user

  def obtain_grade_points(current_user)
    current_date = Time.now.in_time_zone(current_user.time_zone)
    @current_grades ||= Grade.where(created_on: current_date).where(user_id: current_user.id).first
    if @current_grades.nil? || @current_grades.created_on != current_date
      @current_grades = Grade.new(user_id: current_user.id, created_on: current_date, trello_earned_points: 0, trello_total_points: 0, calendar_earned_points: 0, calendar_total_points: 0, earned_points: 0, total_points: 0)
      @current_grades.save!
    end
    @current_grades
  end
end

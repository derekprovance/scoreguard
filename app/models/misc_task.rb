class MiscTask < ActiveRecord::Base
  attr_accessor :current_user

  def total_misc_points
    get_tasks.collect{ |task| task.weight * task.total_points }.sum
  end

  def earned_misc_points
    get_tasks.collect{ |task| task.weight * task.actual_points }.sum
  end

  private

  def get_tasks
    @tasks ||= MiscTask.where(user_id: current_user.id)
  end

end

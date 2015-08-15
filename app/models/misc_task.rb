class MiscTask < ActiveRecord::Base

  def total_misc_points
    get_tasks.collect{ |task| task.weight * task.total_points }.sum
  end

  def earned_misc_points
    get_tasks.collect{ |task| task.weight * task.actual_points }.sum
  end

  private

  def get_tasks
    @tasks ||= MiscTask.all
  end

end

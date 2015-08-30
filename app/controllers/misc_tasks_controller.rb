class MiscTasksController < ApplicationController
  before_action :set_misc_task, only: [:show, :edit, :update, :destroy]

  attr_accessor :current

  # GET /misc_tasks
  # GET /misc_tasks.json
  def index
    @gpa = GpaCalculator.new(current_user)
    @goals = Goal.where(user_id: current_user.id).to_a

    @misc_tasks = MiscTask.where(user_id: current_user.id).to_a
    @task_categories = get_categories

    @tasks = @misc_tasks + @goals
  end

  # GET /misc_tasks/1
  # GET /misc_tasks/1.json
  def show
  end

  def edit_categories
    @task_categories = ""
  end

  def edit_all_categories
    tasks = MiscTask.where(user_id: current_user.id).where(category: params['cat'])

    tasks.each do |task|
      task.category = params['category']
      task.save!
    end

    respond_to do |format|
      format.html { redirect_to '/misc_tasks', notice: "#{params['cat']} was successfully changed." }
      format.json { render :show, status: :created, location: @misc_task }
    end
  end

  # GET /misc_tasks/1/add
  def add
    task = MiscTask.where(id: params['id']).first
    task.actual_points += 1
    respond_to do |format|
      if task.save
        format.html { redirect_to '/misc_tasks', notice: "#{task.name} was successfully incremented." }
      else
        format.json { render json: @misc_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /misc_tasks/new
  def new
    @misc_tasks = MiscTask.new
    @task_categories = get_categories
    @goal = Goal.new
  end

  # GET /misc_tasks/1/edit
  def edit
    @task_categories = get_categories
  end

  # POST /misc_tasks
  # POST /misc_tasks.json
  def create
    @misc_tasks = MiscTask.new(misc_task_params)
    @misc_tasks.user_id = current_user.id

    respond_to do |format|
      if @misc_tasks.save
        format.html { redirect_to '/misc_tasks', notice: 'Misc Task was successfully created.' }
        format.json { render :show, status: :created, location: @misc_task }
      else
        format.html { render :new }
        format.json { render json: @misc_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /misc_tasks/1
  # PATCH/PUT /misc_tasks/1.json
  def update
    respond_to do |format|
      if @misc_tasks.update(misc_task_params)
        format.html { redirect_to '/misc_tasks', notice: 'Misc Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @misc_task }
      else
        format.html { render :edit }
        format.json { render json: @misc_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /misc_tasks/1
  # DELETE /misc_tasks/1.json
  def destroy
    @misc_tasks.destroy
    respond_to do |format|
      format.html { redirect_to '/misc_tasks', notice: 'Misc Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def time_left
    today = Date.today
    left = (today.end_of_week - today).to_i
    if left > 0
      remaining = left.to_s + (left == 1 ? " Day" : " Days")
    elsif left == 0
      remaining = hours_left_in_day.to_s + " Hours"
    end
    remaining
  end

  helper_method :time_left

  private

  def hours_left_in_day
    ((Time.now.end_of_day - Time.now) / 3600).round(0)
  end

  def get_misc_task_percentage
    format_nan_zero(((@gpa.current_grade.misc_earned_points / @gpa.current_grade.misc_total_points.to_f) * 100).round(2))
  end

  def get_categories
    MiscTask.joins("LEFT OUTER JOIN goals ON misc_tasks.id = goals.user_id").where(user_id: current_user.id).select{|u| u.category }.collect{ |u| u.category }.uniq.sort_by{ |e| e.downcase }.to_a
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_misc_task
    @misc_tasks = MiscTask.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def misc_task_params
    params.require(:misc_task).permit(:name, :total_points, :actual_points, :description, :weight, :category)
  end
end

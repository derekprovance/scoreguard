class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  # TODO - Reoccuring calendar events

  # GET /goals
  # GET /goals.json
  def index
    start_date = Time.now.in_time_zone(current_user.time_zone).beginning_of_week
    @goals = Goal.where(user_id: current_user.id)
    @week_goals = Goal.where(user_id: current_user.id).where(starts_at: start_date..start_date+6.days).order('starts_at ASC')
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
  end

  # GET /goals/new
  def new
    @goal = Goal.new
    @task_categories = get_categories
  end

  # GET /goals/1/edit
  def edit
    @task_categories = get_categories
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id

    respond_to do |format|
      if @goal.save
        format.html { redirect_to '/misc_tasks', notice: 'Goal was successfully updated.'}
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to '/misc_tasks', notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to '/misc_tasks', notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_categories
      MiscTask.joins("LEFT OUTER JOIN goals ON misc_tasks.id = goals.user_id").where(user_id: current_user.id).select{|u| u.category }.collect{ |u| u.category }.uniq.sort_by{ |e| e.downcase }.to_a
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:name, :weight, :starts_at, :attended, :category)
    end
end

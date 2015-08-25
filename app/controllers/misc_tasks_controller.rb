class MiscTasksController < ApplicationController
  before_action :set_misc_task, only: [:show, :edit, :update, :destroy]

  attr_accessor :current

  # GET /misc_tasks
  # GET /misc_tasks.json
  def index
    @misc_tasks = MiscTask.where(user_id: current_user.id)
    @misc_task_categories = get_categories
  end

  # GET /misc_tasks/1
  # GET /misc_tasks/1.json
  def show
  end

  def edit_categories
    @misc_task_categories = ""
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
    @misc_task_categories = get_categories
  end

  # GET /misc_tasks/1/edit
  def edit
    @misc_task_categories = get_categories
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

  private
  def get_categories
    MiscTask.where(user_id: current_user.id).select{|u| u.category }.collect{ |u| u.category }.uniq.sort_by{ |e| e.downcase }
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

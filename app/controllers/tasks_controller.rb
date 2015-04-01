class TasksController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :restrict_task_access

  def index
    @tasks = @project.tasks
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def show
    @task = @project.tasks.find(params[:id])
    @comments = @task.comments.all
    @comment = Comment.new
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    project_task = @project.tasks.find(params[:id])
    project_task.destroy
    redirect_to project_tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:description, :completed, :due_date)
  end

  def restrict_task_access
    unless @project.memberships.include?(current_user.memberships.find_by(project_id: @project.id)) || current_user.is_admin?
      flash[:error] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

end

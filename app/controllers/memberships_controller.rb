class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :member_must_be_owner, except: [:index, :destroy]
  before_action :member_to_access_destroy, only: [:destroy]
  before_action :check_last_owner, only: [:update, :destroy]

  def index
    @memberships = @project.memberships.all
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params.merge(project_id: @project.id))
    if @membership.save
      flash[:notice] = "#{@project.memberships.last.user.full_name} was successfully added"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(membership_params)
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def destroy
    @membership = Membership.destroy(params[:id])
    flash[:notice] = "#{@membership.user.full_name} was successfully removed"
    redirect_to projects_path
  end

  private

  def membership_params
    params.require(:membership).permit(:project_id, :user_id, :role_id)
  end

  def member_must_be_owner
    unless current_user.is_owner?(@project) #unless this is true
      flash[:error] = 'You do not have access'
      redirect_to project_path(@project)
    end
  end

  def member_to_access_destroy
    @membership = Membership.find(params[:id])
    unless current_user.is_member?(@membership)
      flash[:error] = "You do not have access"
      redirect_to projects_path
    end
  end

  def check_last_owner
    @membership = @project.memberships.find(params[:id])
    if @membership.role_id == 1 && @project.memberships.where(role_id: 1).count == 1
      flash[:error] = 'Projects must have at least one owner'
      redirect_to project_memberships_path
    end
  end

end

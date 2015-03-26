class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])

  end

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
    redirect_to project_memberships_path
  end

  private

  def membership_params
    params.require(:membership).permit(:project_id, :user_id, :role_id)
  end

end

# I need to create a full_name method inside the User model.

class AboutController < PublicController

  def index
    @projects = Project.all
    @tasks = Task.all
    @project_members = Membership.all
    @users = User.all
    @comments = Comment.all
  end

end

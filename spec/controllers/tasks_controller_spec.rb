require "rails_helper"

describe TasksController do

  let(:user) { create_user(first_name: "User", admin: false) }
  let(:project) { create_project }
  let(:task) { create_task(project) }

  describe "GET #index" do
    it "doesn't allow non-project-member to see tasks" do
      session[:user_id] = user.id

      get :index, project_id: project.id

      expect(response).to redirect_to projects_path
      expect(flash[:error]).to eq("You do not have access to that project")
    end

    it "lists all of a project's tasks for members" do
      session[:user_id] = user.id
      create_owner_membership(project, user)

      get :index, project_id: project.id

      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "shows an individual task" do
      session[:user_id] = user.id
      create_owner_membership(project, user)

      get :show, project_id: project.id, id: task.id

      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do
    it "goes to edit view for task" do
      session[:user_id] = user.id
      create_owner_membership(project, user)

      get :edit, project_id: project.id, id: task.id

      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    it "updates task" do
      session[:user_id] = user.id
      create_owner_membership(project, user)

      patch :update, id: task.id, task: {name: "Have lots of fun forever and ever"}
    end

  end

end

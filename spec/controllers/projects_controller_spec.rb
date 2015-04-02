require "rails_helper"

describe ProjectsController do

  let(:user) { create_user(first_name: "User", admin: false) }
  let(:admin) { create_user(first_name: "User", admin: true, email: "blah@example.com") }
  let(:project) { create_project }
  let(:project2) { create_project }

  describe "GET #index" do
    it "shows everyone's projects to admin" do
      session[:user_id] = admin.id
      create_owner_membership(project, user)

      get :index

      expect(assigns(:projects)).to eq(Project.all)
      expect(response).to render_template(:index)
    end

    it "shows current user's list of projects" do
      session[:user_id] = user.id
      create_owner_membership(project, user)
      create_owner_membership(project2, admin)

      get :index

      expect(assigns(:projects)).to eq([project])
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "shows an individual project" do
      session[:user_id] = user.id
      create_owner_membership(project, user)

      get :show, id: project.id

      expect(assigns(:project)).to eq(project)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "shows the new project form" do
      session[:user_id] = user.id

      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "creates a new project" do
      session[:user_id] = user.id

      post :create, {project: {name: "Have lots of fun"}}

      expect(response).to redirect_to project_tasks_path(Project.find_by(name: "Have lots of fun"))
      expect(flash[:notice]).to eq("Project was successfully created")
    end
  end

  describe "GET #edit" do
    it "goes to edit view for project" do
      session[:user_id] = user.id
      create_owner_membership(project, user)

      get :edit, id: project.id

      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    it "updates a project that current user is a member of" do
      session[:user_id] = user.id
      create_owner_membership(project, user)

      patch :update, id: project.id, project: {name: "Have lots of fun forever and ever"}

      expect(response).to redirect_to project_path(project)
      expect(flash[:notice]).to eq("Project was successfully updated")
    end
  end

  describe "DELETE #destroy" do
    it "deletes an owner's project" do
      session[:user_id] = user.id
      create_owner_membership(project, user)

      delete :destroy, id: project.id

      expect(response).to redirect_to projects_path
      expect(flash[:notice]).to eq("Project was successfully deleted")
    end

    it "doesn't delete a project not owned by current user" do
      session[:user_id] = user.id
      project2 = create_project
      create_owner_membership(project, user)

      delete :destroy, id: project2.id

      expect(response).to redirect_to project_path(Project.find_by(name: "Keep a gratitude journal"))
      expect(flash[:error]).to eq("You do not have access")
    end
  end

end

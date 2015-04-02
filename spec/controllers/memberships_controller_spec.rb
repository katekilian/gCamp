require "rails_helper"

describe MembershipsController do

  let(:user) { create_user(first_name: "User", admin: false) }
  let(:project) { create_project }
  let(:membership) { create_owner_membership(project, user) }

  describe "GET #index" do
    it "shows all memberships for someone who's a member" do
      session[:user_id] = user.id
      create_owner_membership(project, user)

      get :index, project_id: project.id

      expect(response).to render_template(:index)
    end

    it "doesn't show memberships for someone who's not a member" do
      session[:user_id] = user.id

      get :index, project_id: project.id

      expect(response).to redirect_to projects_path
      expect(flash[:error]).to eq("You do not have access to this project")
    end
  end

  describe "PATCH #update" do
    it "updates membership if current user is owner" do
      session[:user_id] = user.id
      membership = create_owner_membership(project, user)
      user2 = create_user(email: "happy@example.com")
      membership2 = create_owner_membership(project, user2)

      patch :update, {project_id: project.id, id: membership2.id, membership: { role_id: 2 }}

      expect(response).to have_http_status(302)
      expect(flash[:notice]).to eq("Sally Hansen was successfully updated")
    end

    it "cannot update one's own membership if current user is member" do
      session[:user_id] = user.id
      membership = create_owner_membership(project, user, role_id: 2)

      patch :update, {project_id: project.id, id: membership.id, membership: { role_id: 1 }}

      expect(response).to redirect_to project_path(project)
      expect(flash[:error]).to eq("You do not have access")
    end
  end

  describe "DELETE #destroy" do
    it "can't delete another person's membership" do
      session[:user_id] = user.id
      user2 = create_user(email: "happy@example.com")
      user3 = create_user(email: "sad@example.com")

      membership = create_owner_membership(project, user, role_id: 2)
      membership2 = create_owner_membership(project, user2, role_id: 2)
      membership3 = create_owner_membership(project, user3)

      delete :destroy, {project_id: project.id, id: membership2.id}

      expect(response).to redirect_to projects_path
      expect(flash[:error]).to eq("You do not have access")
    end
  end


end

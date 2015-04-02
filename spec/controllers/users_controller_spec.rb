require "rails_helper"

describe UsersController do

  let(:user) { create_user(first_name: "User", admin: false) }

  describe "GET #index" do
    it "shows all users" do
      session[:user_id] = user.id

      get :index

      expect(assigns(:users)).to eq(User.all)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "shows an individual user" do
      session[:user_id] = user.id

      get :show, id: user.id

      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "shows the new user form" do
      session[:user_id] = user.id

      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    describe "on success" do
      it "creates a new user" do
        session[:user_id] = user.id

        post :create, {user: {first_name: "Minnie", last_name: "Mouse", email: "mouse@example.com", password: "password"}}

        expect(response).to redirect_to users_path
        expect(flash[:notice]).to eq("User was successfully created")
      end
    end
  end

  describe "GET #edit" do
    it "renders edit form for current user" do
      session[:user_id] = user.id

      get :edit, id: user.id

      expect(response).to render_template(:edit)
    end

    it "doesn't render edit form for anyone but current user" do
      session[:user_id] = user.id
      user2 = create_user(email: "bob@marley.com")

      get :edit, id: user2.id

      expect(response).to have_http_status(404)
    end
  end

  describe "PATCH #update" do
    it "updates the current user" do
      session[:user_id] = user.id

      patch :update, id: user.id, user: {first_name: "Minny", last_name: "Mousey", email: "mouse@example.com"}

      expect(response).to redirect_to users_path
      expect(flash[:notice]).to eq("User was successfully updated")
    end

    it "doesn't update for anyone but current user" do
      session[:user_id] = user.id
      user2 = create_user(email: "bob@marley.com")

      post :update, id: user2.id

      expect(response).to have_http_status(404)
    end
  end

  describe "DELETE #destroy" do
    it "deletes current user's record" do
      session[:user_id] = user.id

      delete :destroy, id: user.id

      expect(response).to redirect_to root_path
    end

    it "doesn't delete anyone else's record" do
      session[:user_id] = user.id
      user2 = create_user(email: "bob@marley.com")

      delete :destroy, id: user2.id

      expect(response).to have_http_status(404)
    end
  end

end

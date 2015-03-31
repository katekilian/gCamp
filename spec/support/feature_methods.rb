def login(user = create_user)
  visit sign_in_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  within("form") do
    click_on 'Sign In'
  end
end

def goto_project_tasks_index
  @user = create_user
  login(@user)
  @project = create_project
  create_owner_membership(@project, @user)
  @task = create_task(@project)
  visit project_tasks_path(@project)
end

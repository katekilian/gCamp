def create_user(options = {})
  User.create!({
    first_name: "Sally",
    last_name: "Hansen",
    email: "sally@example.com",
    password: "password",
    password_confirmation: "password"
  }.merge(options))
end

def create_project(options = {})
  Project.create!({name: "Keep a gratitude journal"}.merge(options))
end

def create_task(project = create_project, options = {})
  Task.create!({
    description: "Buy a nice notebook",
    due_date: "03/20/2015",
    project_id: project.id
  }.merge(options))
end

def create_owner_membership(project = create_project, user = create_user, options = {})
  Membership.create!({
    project_id: project.id,
    user_id: user.id,
    role_id: 1
  }.merge(options))

end

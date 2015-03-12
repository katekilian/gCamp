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

def create_task(options = {})
  Task.create!({
    description: "Buy a nice notebook",
    due_date: "03/20/2015",
    project_id: Project.first.id
  }.merge(options))
end

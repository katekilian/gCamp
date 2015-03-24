namespace :cleanup do

  desc "Removes all memberships where their users have already been deleted"
  task removes_memberships_deleted_users: :environment do
    existing_users_ids = User.pluck(:id)
    memberships_without_users = Membership.where.not(user_id: existing_users_ids).destroy_all
    p "#{memberships_without_users} have been removed"
  end

  desc "Removes all memberships where their user_id is nil"
  task removes_memberships_nil_users: :environment do
    memb_with_nil_userid = Membership.where(user_id: nil).destroy_all
    p "#{memb_with_nil_userid} have been deleted"
  end

  desc "Removes all memberships where their projects have already been deleted"
  task removes_memberships_deleted_projects: :environment do
    existing_projects = Project.pluck(:id)
    memberships_without_projects = Membership.where.not(project_id: existing_projects)
    p "#{memberships_without_projects} have been deleted"
  end

  desc "Removes all tasks where their projects have been deleted"
  task removes_tasks_deleted_projects: :environment do
    existing_projects = Project.pluck(:id)
    tasks_without_projects = Task.where.not(project_id: existing_projects)
    p "#{tasks_without_projects} have been deleted"
  end

  desc "Removes all comments where their tasks have been deleted"
  task removes_comments_deleted_tasks: :environment do
    existing_tasks = Task.pluck(:id)
    comments_without_tasks = Comment.where.not(task_id: existing_tasks)
    p "#{comments_without_tasks} have been deleted"
  end

  desc "Sets the user_id of comments to nil if their users have been deleted"
  task comments_deleted_users_nil: :environment do
    existing_users = User.pluck(:id)
    comments_without_users = Comment.where.not(user_id: existing_users)
    if comments_without_users.any?
      comments_without_users.update_all(user_id: nil)
    end
    p "#{comments_without_users} have been set to nil user_id"
  end

  desc "Removes any tasks with null project_id"
  task remove_tasks_null_projectid: :environment do
    tasks_null_projectid = Task.where(project_id: nil).destroy_all
    p "#{tasks_null_projectid} were removed"
  end

  desc "Removes any comments with a null task_id"
  task remove_comments_null_taskid: :environment do
    comments_null_taskid = Comment.where(task_id: nil).destroy_all
    p "#{comments_null_taskid} were removed"
  end

  desc "Removes any memberships with a null project_id or user_id"
  task remove_memberships_null_projectuserid: :environment do
    memb_null_projectid = Membership.where(project_id: nil).destroy_all
    memb_null_userid = Membership.where(user_id: nil).destroy_all
    p "#{memb_null_projectid} and #{memb_null_userid} were removed"
  end
  
end

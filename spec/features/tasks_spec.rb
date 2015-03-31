require 'rails_helper'

feature "Tasks" do

  before do
    goto_project_tasks_index
  end

  scenario "User can see an index of all tasks for a specific project" do
    expect(page).to have_content "Keep a gratitude journal"
    expect(page).to have_content "Tasks"
    expect(page).to have_content "Description"
    expect(page).to have_content "Due on"
  end

  scenario "User can go to the New Task view" do
    expect(page).to have_content "New Task"
    click_on "New Task"
    expect(current_path).to eq(new_project_task_path(@project))
  end

  scenario "User can create a new task" do
    visit new_project_task_path(@project)
    expect(page).to have_content "New Task"
    fill_in :task_description, with: "I'm a new task"
    fill_in "Due date", with: "03/20/2015"
    click_on "Create Task"
    expect(current_path).to eq(project_task_path(@project, Task.last))
    expect(page).to have_content "Task was successfully created."
  end

  scenario "User can edit and update a task" do
    click_on "Edit"
    expect(current_path).to eq(edit_project_task_path(@project, @task))
    expect(page).to have_content "Buy a nice notebook"
    fill_in "Description", with: "I'm a task, and I like it!"
    click_button "Update Task"
    expect(current_path).to eq(project_task_path(@project, @task))
    expect(page).to have_content 'Task was successfully updated.'
  end

  scenario "User can delete tasks" do
    # click_on("", href: '/projects/4/tasks/23')
    # expect(current_path).to eq(project_tasks_path(@project))
  end

  scenario "User cannot see tasks for projects of which they are not a member" do
    # fill in with code
  end

end

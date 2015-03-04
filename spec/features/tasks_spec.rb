require 'rails_helper'

feature "Tasks" do

  scenario "User can see an index of all tasks" do
    visit tasks_path
    expect(page).to have_content "Tasks"
    expect(page).to have_content "Description"
    expect(page).to have_content "Due on"
  end

  scenario "User can go to the New Task view" do
    visit tasks_path
    expect(page).to have_content "New Task"
    click_on "New Task"
    expect(current_path).to eq(new_task_path)
  end

  scenario "User can create a new task" do
    visit new_task_path
    expect(page).to have_content "New Task"
    fill_in :task_description, with: "I'm a new task"
    fill_in "Due date", with: "03/20/2015"
    click_on "Create Task"
    expect(current_path).to eq(task_path(Task.last))
    expect(page).to have_content "Task was successfully created."
  end

  scenario "User can edit and update a task" do
    task = Task.create!(description: "I'm a task")
    visit tasks_path
    click_on "Edit"
    expect(current_path).to eq(edit_task_path(task))
    expect(page).to have_content "I'm a task"
    fill_in "Description", with: "I'm a task, and I like it!"
    click_button "Update Task"
    expect(current_path).to eq(task_path(task))
    expect(page).to have_content 'Task was successfully updated.'
  end

  scenario "User can delete tasks" do
    task = Task.create!(description: "I'm a task")
    visit tasks_path
    click_on "Destroy"
    expect(current_path).to eq(tasks_path)
  end

end

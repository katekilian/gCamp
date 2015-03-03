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
    expect(page).to have_content 
  end

end

require 'rails_helper'

feature "Projects" do

  before do
    login
  end

  scenario "User can see a list of all projects" do
    visit projects_path
    expect(page).to have_content "Projects"
    expect(page).to have_content "Name"
  end

  scenario "User can see an individual project" do
    project = Project.create!(name: "Keep a gratitude journal")
    visit projects_path
    click_on "Keep a gratitude journal"
    expect(current_path).to eq(project_path(project))
    expect(page).to have_content "Edit"
    expect(page).to have_content "Delete"
  end

  scenario "User can create a new project" do
    visit projects_path
    click_link("New Project", match: :first)
    fill_in "Name", with: "Keep a gratitude journal"
    click_on "Create Project"
    expect(current_path).to eq(project_path(Project.last))
    expect(page).to have_content "Project was successfully created"
  end

  scenario "User gets error when creating project with empty name" do
    visit projects_path
    click_link("New Project", match: :first)
    fill_in "Name", with: ""
    click_on "Create Project"
    expect(page).to have_content "Name can't be blank"
  end

  scenario "User can edit and update a project" do
    project = Project.create!(name: "Keep a gratitude journal")
    visit projects_path
    click_on "Keep a gratitude journal"
    click_on "Edit"
    expect(current_path).to eq(edit_project_path(project))
    fill_in "Name", with: "Keep a DAILY gratitude journal"
    click_on "Update Project"
    expect(current_path).to eq(project_path(project))
    expect(page).to have_content "Project was successfully updated"
  end

  scenario "User can delete projects" do
    project = Project.create!(name: "Keep a gratitude journal")
    visit project_path(project)
    click_on "Delete"
    expect(current_path).to eq(projects_path)
    expect(page).to have_content "Project was successfully deleted"
  end
  
end

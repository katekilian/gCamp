require "rails_helper"

feature "Tasks" do

  scenario "User can see an index of all users" do
    visit users_path
    expect(page).to have_content "Users"
    expect(page).to have_content "Name"
    expect(page).to have_content "Email"
  end

  scenario "User can see an individual user" do
    user = User.create!(first_name: "Charlie", last_name: "Chaplin", email: "charliechaplin@example.com")
    visit users_path
    click_on "Charlie Chaplin"
    expect(current_path).to eq(user_path(user))
    expect(page).to have_content "Edit"
  end

  scenario "User can go to the New User view" do
    visit users_path
    click_on "New User"
    expect(current_path).to eq(new_user_path)
  end

  scenario "User can create a new user record" do
    visit new_user_path
    expect(page).to have_content "New User"
    fill_in "First name", with: "Charlie"
    fill_in "Last name", with: "Chaplin"
    fill_in "Email", with: "charliechaplin@example.com"
    click_on "Create User"
    expect(current_path).to eq(users_path)
    expect(page).to have_content "User was successfully created"
  end

  scenario "User can edit and update a user" do
    user = User.create!(first_name: "Charlie", last_name: "Chaplin", email: "charliechaplin@example.com")
    visit users_path
    click_on "edit"
    fill_in "First name", with: "Charles"
    fill_in "Last name", with: "Chaplain"
    fill_in "Email", with: "cc@example.com"
    click_on "Update User"
    expect(current_path).to eq(users_path)
    expect(page).to have_content "User was successfully updated"
  end

  scenario "User can delete users" do
    user = User.create!(first_name: "Charlie", last_name: "Chaplin", email: "charliechaplin@example.com")
    visit users_path
    click_on "edit"
    click_on "Delete User"
    expect(current_path).to eq(users_path)
    expect(page).to have_content "User was successfully deleted"
  end

end

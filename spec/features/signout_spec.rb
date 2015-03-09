require 'rails_helper'

feature 'Sign out' do

  scenario 'User can sign out' do
    user = User.create!(first_name: "Penelope", last_name: "Penguin", email: "penelope@example.com", password: "password")
    visit sign_in_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    within("form") { click_on "Sign In"}
    expect(current_path).to eq(root_path)
    visit root_path
    click_on "Sign Out"
    expect(current_path).to eq(root_path)
    expect(page).to have_content "You have successfully signed out"
    expect(page).to_not have_content "Penelope Penguin"
  end

end

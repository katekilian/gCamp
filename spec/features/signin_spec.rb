require 'rails_helper'

feature 'Sign in' do

  scenario 'User can sign in' do
    user = User.create!(first_name: "Penelope", last_name: "Penguin", email: "penelope@example.com", password: "password")
    visit sign_in_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    within("form") { click_on "Sign In"}
    expect(current_path).to eq(root_path)
    expect(page).to have_content "You have successfully signed in"
    expect(page).to have_content "Penelope Penguin"
  end

  scenario 'User can see validation error messages if fields are missing information' do
    visit sign_in_path
    within("form") { click_on "Sign In"}
    expect(current_path).to eq(sign_in_path)
    expect(page).to have_content "Email / Password combination is invalid"
  end

end

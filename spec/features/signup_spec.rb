require 'rails_helper'

feature 'Sign up' do

  scenario 'User can go to sign up page from root path' do
    visit root_path
    click_on "Sign Up"
    expect(current_path).to eq(sign_up_path)
    expect(page).to have_content "Sign up for gCamp!"
  end

  scenario 'User can fill out and submit sign up form' do
    visit sign_up_path
    fill_in "First Name", with: "Penelope"
    fill_in "Last Name", with: "Penguin"
    fill_in "Email", with: "penguin@example.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    within("form") { click_on "Sign Up" }
    expect(current_path).to eq(new_project_path)
    expect(page).to have_content "You have successfully signed up"
  end

  scenario 'User can see validation error messages if fields are missing information' do
    visit sign_up_path
    within("form") { click_on "Sign Up" }
    expect(current_path).to eq(sign_up_path)
    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end
end

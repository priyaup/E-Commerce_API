require 'rails_helper'

RSpec.feature "Admin Management", type: :feature do
  let!(:admin_user) { create(:admin_user) }

  before do
    visit new_admin_user_session_path
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: admin_user.password

    # Debugging step to inspect the page before clicking
    save_and_open_page

    click_button 'Login' # Ensure this matches exactly with the button's text
  end

  scenario "Admin user can view the list of admin users" do
    visit admin_admin_users_path

    expect(page).to have_content('Admin Users')
    expect(page).to have_content(admin_user.email)
  end

  scenario "Admin user can create a new admin user" do
  visit new_admin_admin_user_path

  fill_in 'Email', with: 'new_admin@example.com'
  
  # Update this to a specific field selector
  fill_in 'admin_user_password', with: 'password'  # Change based on actual ID
  fill_in 'admin_user_password_confirmation', with: 'password'  # Ensure this matches as well

  click_button 'Create Admin user'

  expect(page).to have_content('Admin user was successfully created.')
  expect(page).to have_content('new_admin@example.com')
end

end

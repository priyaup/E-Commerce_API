require 'rails_helper'

RSpec.feature 'User Management', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let!(:user) { create(:user, email: 'testuser@example.com') }

  before do
    visit new_admin_user_session_path
    fill_in 'admin_user_email', with: admin_user.email
    fill_in 'admin_user_password', with: admin_user.password
    click_button 'Login'
  end

  scenario 'Admin user can create a new user' do
    visit new_admin_user_path 
    fill_in 'user_email', with: 'newuser@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Create User'
    
    expect(page).to have_content('User was successfully created.')
    expect(User.last.email).to eq('newuser@example.com')
  end

  scenario 'Admin user can edit an existing user' do
    visit edit_admin_user_path(user)
    fill_in 'user_email', with: 'updateduser@example.com'
    fill_in 'user_password', with: 'newpassword'
    fill_in 'user_password_confirmation', with: 'newpassword'
    click_button 'Update User'
    
    expect(page).to have_content('User was successfully updated.')
    expect(user.reload.email).to eq('updateduser@example.com')
  end

  scenario 'Admin can delete a user' do
    login_as(admin_user, scope: :admin_user)

    visit admin_users_path  

    expect(page).to have_content(user.email)  

    within("#user_#{user.id}") do  
      click_link 'Delete'
    end

    page.driver.browser.switch_to.alert.accept

    expect(page).to have_content('User was successfully destroyed.')  # Adjusted message to match ActiveAdmin response

    expect(page).not_to have_content(user.email)
  end
end

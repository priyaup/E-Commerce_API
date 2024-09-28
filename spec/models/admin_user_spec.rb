# spec/models/admin_user_spec.rb
require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it "is valid with a valid email and password" do
    admin_user = AdminUser.new(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
    expect(admin_user).to be_valid
  end

  it "is invalid without an email" do
    admin_user = AdminUser.new(email: nil, password: 'password')
    expect(admin_user).not_to be_valid
  end

  it "validates the password confirmation" do
    admin_user = AdminUser.new(email: 'admin@example.com', password: 'password', password_confirmation: 'wrongpassword')
    expect(admin_user).not_to be_valid
  end
end

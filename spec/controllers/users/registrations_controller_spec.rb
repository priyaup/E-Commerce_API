require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe "POST #create" do
    let(:valid_attributes) { { email: Faker::Internet.email, password: 'password', password_confirmation: 'password' } }
    let(:invalid_attributes) { { email: '', password: 'short', password_confirmation: 'short' } }

    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context "with valid attributes" do
      it "creates a new user and returns success message" do
        post :create, params: { user: valid_attributes }, format: :json
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['status']['message']).to eq('Signed up successfully')
      end
    end

    context "with invalid attributes" do
      it "does not create a new user and returns error messages" do
        post :create, params: { user: invalid_attributes }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['status']['message']).to eq('User could not be created successfully')
        expect(json_response['status']['errors']).to include("Email can't be blank")
      end
    end
  end
end

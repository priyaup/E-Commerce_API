class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  private 
  def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully', data: resource }
      }, status: :ok
    else
      render json: {
        status: { message: 'User could not be created successfully', errors: resource.errors.full_messages }
      }, status: :unprocessable_entity
    end
  end
end

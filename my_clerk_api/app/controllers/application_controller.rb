require "clerk/authenticatable"

class ApplicationController < ActionController::API

  def current_user
    origin_app = request.headers['Origin-App']
    token = request.headers['Authorization']

    if origin_app == 'App-A'
      clerk_secret = ENV['CLERK_API_KEY_A'] # sk_test_..etc
    else
      clerk_secret = ENV['CLERK_API_KEY_B'] # sk_test_..etc
    end

    sdk = Clerk::SDK.new(api_key: clerk_secret)
    session = sdk.verify_token(token)
    sdk.users.find(session['sub'])
  end

  def show_current_user
    if current_user
      render json: { user: current_user_attributes }
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  private

  def current_user_attributes
    {
      id: current_user["id"],
      firstName: current_user["first_name"],
      lastName: current_user["last_name"],
    }
  end
end
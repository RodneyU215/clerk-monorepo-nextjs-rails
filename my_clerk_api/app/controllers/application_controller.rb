require "clerk/authenticatable"
require 'pry'

class ApplicationController < ActionController::API
  include Clerk::Authenticatable

  def current_user
    @current_user ||= clerk_user
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
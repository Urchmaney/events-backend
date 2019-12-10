# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate

  def logged_in?
    !!current_user
  end
  
  def current_user
    if auth_present?
      if !auth
        return nil
      end
      user = User.find(auth['user'])
      if user
        @current_user ||= user
      end
    end
  end

  def authenticate
    render json: {error: "unauthorized"}, status: 401 unless logged_in?
  end

  private

  def token
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer/).flatten.first
  end

end

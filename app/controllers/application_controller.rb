# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate

  def logged_in?
    current_user ? true : false
  end

  def current_user
    return nil unless auth_present?
    return nil unless auth

    user = User.find(auth['user'])

    return nil unless user

    @current_user ||= user
  end

  def authenticate
    render json: { error: 'unauthorized' }, status: 401 unless logged_in?
  end

  private

  def token
    request.env['HTTP_AUTHORIZATION'].scan(/Bearer (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    return false unless request.env['HTTP_AUTHORIZATION']
    request.env['HTTP_AUTHORIZATION'].scan(/Bearer/).flatten.first
  end
end

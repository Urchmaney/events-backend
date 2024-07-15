# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate, except: :setup

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

  def setup
    admin = User.find_by(email: ENV['ADMIN_EMAIL'])
    result = 'Already Exists.'
    if !admin
      user = User.create(email: ENV['ADMIN_EMAIL'],firstname: ENV['ADMIN_FIRSTNAME'],
      lastname: ENV['ADMIN_LASTNAME'], password: ENV['ADMIN_PASSWORD'], username: ENV['ADMIN_USERNAME'],
    is_admin: true)
      result = 'Successfully created admin' if user.valid?
      result = user.errors.full_messages unless user.valid?
    end
    render json: result, status: 200
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

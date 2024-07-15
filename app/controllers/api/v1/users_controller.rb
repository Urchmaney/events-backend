# frozen_string_literal: true

class API::V1::UsersController < ApplicationController
  skip_before_action :authenticate
  
  def create
    user = User.create(user_params);
    jwt = Auth.issue(user: user.id)
    result = { user: user, token: jwt }
    status = 200
    if !user.valid?
      status = 400
      result = { error: user.errors.full_messages }
    end    
    render json: result, status: status    
  end

  private
  def user_params
    params.permit(:username, :password, :password_confirmation, :firstname, :lastname, :email)
  end
end

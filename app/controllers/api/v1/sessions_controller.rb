# frozen_string_literal: true

class API::V1::SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    user = User.find_by(email: auth_params[:email])
    result = { error: 'Incorrect details.' }
    status = 400
    if user&.authenticate(auth_params[:password])
      jwt = Auth.issue(user: user.id)
      result = { token: jwt } 
      status = 200
    end
    render json: result , status: status
  end

  private

  def auth_params
    params.require('auth').permit(:email, :password)
  end
end

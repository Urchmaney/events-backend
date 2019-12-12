# frozen_string_literal: true

class API::V1::SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    user = User.find_by(email: auth_params[:email])
    if user&.authenticate(auth_params[:password])
      jwt = Auth.issue(user: user.id)
      render json: { jwt: jwt } && return
    end
    render json: { error: 'Incorrect details' }, status: 400
  end

  private

  def auth_params
    params.require('auth').permit(:email, :password)
  end
end

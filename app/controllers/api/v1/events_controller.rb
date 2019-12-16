# frozen_string_literal: true

class API::V1::EventsController < ApplicationController
  before_action :authenticate

  def index
    render json: current_user.events , status: 200
  end

  def all
    render json: Event.all , status: 200
  end
end

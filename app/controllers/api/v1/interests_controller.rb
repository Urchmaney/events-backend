# frozen_string_literal: true

class API::V1::InterestsController < ApplicationController
  before_action :authenticate

  def index
    event = Event.find(params[:id])
    status = 400
    result = 'Invalid event id'
    if event
      result = event.users
      status = 200
    end
    render json: result , status: status
  end

  def create
    event = Event.find(params[:id])
    status = 400
    result = 'Invalid event id'
    if event
      interest = Interest.create(user: current_user, event: event)
      result = current_user.events
      status = 200
    end
    render json: result , status: status
  end
end

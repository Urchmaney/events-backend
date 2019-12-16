# frozen_string_literal: true

class API::V1::EventsController < ApplicationController
  before_action :authenticate

  def index
    render json: current_user.events , status: 200
  end

  def all
    render json: Event.all , status: 200
  end

  def organizers
    @event = Event.find(params[:id])
    status = 400
    result = 'Invalid event id'
    if @event
      result = @event.organizers.group_by{ |ele| ele.role }
      status = 200
    end
    render json: result , status: status
  end

  def interest
    @event = Event.find(params[:id])
    status = 400
    result = 'Invalid event id'
    if @event
      result = @event.users
      status = 200
    end
    render json: result , status: status
  end

end

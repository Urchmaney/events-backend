class EventsController < ApplicationController
  before_action :authenticate

  def index
    render json: currentUser.events , status: 200
  end

  def all
    render json: currentUser.events , status: 200
  end

  def organizers
    @event = Event.find(params[:id])
    status = 400
    result = 'Invalid event id'
    if @event
      result = @event.organizers
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

# frozen_string_literal: true

class API::V1::EventsController < ApplicationController
  before_action :authenticate

  def index
    render json: current_user.events , status: 200
  end

  def all
    render json: Event.all.where('start > ?', DateTime.now) , status: 200
  end

  def create
    status = 200
    result = 'Successfully Added Event.'
    event = Event.create(events_params)
    if !event.valid?
      status = 400
      result = { error: user.errors.full_messages }
    end
    render json: result , status: status
  end

  private

  def events_params
    params.require(:event).permit(:title, :description, :location, :start, :end, organizers_attributes: [:name, :role, :occupation])
  end
end

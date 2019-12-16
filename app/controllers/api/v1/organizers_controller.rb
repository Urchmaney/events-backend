# frozen_string_literal: true

class API::V1::OrganizersController < ApplicationController
  before_action :authenticate

  def index
    @event = Event.find(params[:id])
    status = 400
    result = 'Invalid event id'
    if @event
      result = @event.organizers.group_by{ |ele| ele.role }
      status = 200
    end
    render json: result , status: status
  end
end

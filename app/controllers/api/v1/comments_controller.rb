# frozen_string_literal: true

class API::V1:: CommentsController < ApplicationController
  before_action :authenticate

  def index
    event = Event.find_by(id: params[:id])
    status = 400
    result = { error: ['Invalid event id']}
    if event
      comments = Comment.where('event_id = ?', params[:id]).eager_load(:user)
      status = 200
      result = comments
    end
    render json: result, include: { user: { only: [:firstname, :lastname]} }, status: status
  end

  def create
    event = Event.find_by(id: params[:id])
    result = { error: ['Invalid event id'] }
    status = 400
    if event
      comment = Comment.create(event: event, user: current_user, content: comment_param[:content])
      status = 200
      result = Comment.where('event_id = ?', params[:id]).eager_load(:user)
    end
    render json: result, include: { user: { only: [:firstname, :lastname]} } , status: status
  end

  private

  def comment_param
    params.permit(:id, :content);
  end
end

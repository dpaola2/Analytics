class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]
  
  def index
    authorize! :read, Event, :message => 'Not authorized as an administrator.'
    @event_count = Event.count
    @events = Event.order('created_at DESC').page(params[:page]).per_page(10)
  end

  def show
    authorize! :read, Event, :message => 'Not authorized as an administrator.'
    @event = Event.find params[:id]
  end

  def create
    blob = event_params
    @event = Event.new(:blob => blob)
    if @event.save
      respond_to do |format|
        format.js
        format.json
        format.html { render :layout => false}
      end
    end
  end

  private

  def event_params
    request.raw_post
  end
end

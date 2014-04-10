class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]
  
  def index
    @event_count = Event.count
    @events = Event.order('created_at DESC').page(params[:page]).per_page(100)
  end

  def show
    @event = Event.find params[:id]
  end

  def create
    raw = event_params
    blob = raw
    begin
      blob = event_params.to_json
    rescue Exception => e
      blob = "BAD: #{raw}"
    end
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

class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]
  
  def index
    @events = Event.all
  end

  def new
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
    params.permit!
    actuals = params.dup
    actuals.delete(:action)
    actuals.delete(:controller)
    actuals
  end
end
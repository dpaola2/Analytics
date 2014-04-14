class StandardEventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :read, StandardEvent, :message => 'Not authorized as an administrator.'
    @standard_events = StandardEvent.select('DISTINCT name')
  end

  def show
    authorize! :read, StandardEvent, :message => 'Not authorized as an administrator.'
    @standard_event_name = params[:id]
  end

  def event_data
    authorize! :read, StandardEvent, :message => 'Not authorized as an administrator.'
    @fact = params[:id]
    @klass = StandardEvent
    render json: retrieve_fact_by_dimensions # in application_controller.rb
  end

  def event_summary
    authorize! :read, StandardEvent, :message => 'Not authorized as an administrator.'
    @standard_events = StandardEvent.select('DISTINCT name')
    @data = @standard_events.map do |e|
      @fact = e.name
      @klass = StandardEvent
      {name: e.name, data: retrieve_fact_by_dimensions}
    end
    render json: @data
  end
end

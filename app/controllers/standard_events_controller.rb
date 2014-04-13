class StandardEventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @standard_events = StandardEvent.select('DISTINCT name')
  end

  def show
    @standard_event_name = params[:id]
  end

  def event_data
    @fact = params[:id]
    @klass = StandardEvent
    retrieve_fact_by_dimensions # in application_controller.rb
  end
end

class StandardEventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @standard_events = StandardEvent.select('DISTINCT name')
  end

  def show
    @standard_event_name = params[:id]
  end
end

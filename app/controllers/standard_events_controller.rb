class StandardEventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @standard_events = StandardEvent.select('DISTINCT name')
  end

  def show
    @standard_event_name = params[:id]
  end

  def event_data
    @standard_event_name = params[:id]
    by = params[:by] || "day"
    if by == "day"
      last = 30
      format = "%m/%d/%Y"
    elsif by == "week"
      last = 6
      format = "%m/%d/%Y"
    elsif by == "hour"
      last = 24
      format = "%l%p"
    else
      last = 12
      format = "%m/%d/%Y"
    end
    render json: StandardEvent.where(:name => @standard_event_name).send("group_by_#{by}".to_sym ,:timestamp, :last => last, :format => format).count
  end
end

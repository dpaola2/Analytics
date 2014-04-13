class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  def retrieve_fact_by_dimensions
    by = params[:by] || "day"
    if by == "day"
      last = 30
      format = "%m/%d/%Y"
      group_clause = :group_by_day
      group_dimension = :timestamp
    elsif by == "week"
      last = 6
      format = "%m/%d/%Y"
      group_clause = :group_by_week
      group_dimension = :timestamp
    elsif by == "hour"
      last = 24
      format = "%l%p"
      group_clause = :group_by_hour
      group_dimension = :timestamp
    else
      last = 12
      format = "%m/%d/%Y"
      group_clause = :group_by_day
      group_dimension = :timestamp
    end
    if @fact.index(",") # multiple
      @fact.split(",").collect {|f| @klass.send(group_clause, group_dimension, :last => last, :format => format).count }
    elsif @fact == "*"
      @klass.send(group_clause, group_dimension, :last => last, :format => format).count
    else
      @klass.where(:name => @fact).send(group_clause, group_dimension, :last => last, :format => format).count
    end
  end
end

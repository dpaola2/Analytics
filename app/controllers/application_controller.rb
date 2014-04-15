class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  def retrieve_fact_by_dimensions
    by = params[:by] || "daily"
    last = params[:last] || 30
    group_clause = group_clause_mapper[by]
    if by == "daily"
      format = "%m/%d/%Y"
      group_dimension = :timestamp
    elsif by == "weekly"
      format = "%m/%d/%Y"
      group_dimension = :timestamp
    elsif by == "hourly"
      format = nil
      group_dimension = :timestamp
    else
      format = "%m/%d/%Y"
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

  def group_clause_mapper
    {
      "hourly" => :group_by_hour,
      "daily" => :group_by_day,
      "weekly" => :group_by_week,
      "monthly" => :group_by_month
    }
  end
end

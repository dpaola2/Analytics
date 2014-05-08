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
    group_dimension = :timestamp
    case by
    when "daily"
      format = "%m/%d/%Y"
    when "weekly"
      format = "%m/%d/%Y"
    when "hourly"
      format = nil
    when "day_of_week"
      format = "%A"
      last = nil
    when "hour_of_day"
      format = "%l %P"
      last = nil
    when 'hours_by_weekday'
      hash = {}
      Date::DAYNAMES.each_with_index do |day, index| # 0 is sunday
        hash[day] = @klass.where(:name => @fact)
                          .where("EXTRACT(DOW FROM timestamp) = ?", index)
                          .group_by_hour_of_day(group_dimension, last: nil, format: '%l%p').count
      end
      return hash
    else
      format = "%m/%d/%Y"
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
      "monthly" => :group_by_month,
      "day_of_week" => :group_by_day_of_week,
      "hour_of_day" => :group_by_hour_of_day
    }
  end
end

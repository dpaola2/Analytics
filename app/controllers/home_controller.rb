class HomeController < ApplicationController
  def index
    hourly_groups = Event.group_by_hour(:created_at, :last => 24).count
    amounts = hourly_groups.collect {|key, val| val }
    @avg_per_hour = amounts.sum / amounts.count
  end
end

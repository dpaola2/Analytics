class IdentitiesController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def summary
    render json: Identity.group_by_week(:created, :last => 12, :format => "%m/%d/%Y").count
  end
end

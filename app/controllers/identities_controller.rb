class IdentitiesController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :read, Identity, :message => 'Not authorized as an administrator.'
  end

  def summary
    authorize! :read, Identity, :message => 'Not authorized as an administrator.'
    render json: Identity.group_by_week(:created, :last => 12, :format => "%m/%d/%Y").count
  end
end

class PageViewsController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :read, PageView, :message => 'Not authorized as an administrator.'
  end

  def page_data
    authorize! :read, PageView, :message => 'Not authorized as an administrator.'
    @fact = params[:id]
    @klass = PageView
    render json: retrieve_fact_by_dimensions # in application_controller.rb
  end
end

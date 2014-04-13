class PageViewsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def page_data
    @fact = params[:id]
    @klass = PageView
    render json: retrieve_fact_by_dimensions # in application_controller.rb
  end
end

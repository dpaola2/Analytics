class CohortsController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :read, Cohort, :message => 'Not authorized as an administrator.'
    @cohorts = Cohort.all
  end

  def new
    authorize! :read, Cohort, :message => 'Not authorized as an administrator.'
    @cohort = Cohort.new
  end

  def create
    authorize! :manage, Cohort, :message => 'Not authorized as an administrator.'
    @cohort = Cohort.new cohort_params
    if @cohort.save
      flash[:success] = "Saved."
      redirect_to cohorts_path
    end
  end

  def show
    authorize! :manage, Cohort, :message => 'Not authorized as an administrator.'
    @cohort = Cohort.find params[:id]
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name, :segment_definition_id, :time_bucket)
  end
end

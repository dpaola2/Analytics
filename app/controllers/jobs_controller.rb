class JobsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    authorize! :read, Delayed::Job
    @jobs = Delayed::Job.page(params[:page]).per_page(10)
    @active_jobs = Delayed::Job.where('locked_at is not null')
  end

  def show
    authorize! :read, Delayed::Job
    begin
      @job = Delayed::Job.find params[:id]
    rescue Exception => e
      flash[:error] = "No Job with that ID."
      redirect_to jobs_path
    end
  end
end

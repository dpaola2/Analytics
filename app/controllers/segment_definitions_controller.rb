class SegmentDefinitionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    authorize! :read, SegmentDefinition, :message => 'Not authorized as an administrator.'
    @segment_defs = SegmentDefinition.all
  end

  def new
    authorize! :manage, SegmentDefinition, :message => 'Not authorized as an administrator.'
    @segment_def = SegmentDefinition.new
  end

  def create
    authorize! :manage, SegmentDefinition, :message => 'Not authorized as an administrator.'
    @segment_def = SegmentDefinition.new segment_definition_params
    @segment_def.user_id = current_user.id
    if @segment_def.save
      flash[:success] = "Saved."
      redirect_to segment_definitions_path
    end
  end

  def show
    authorize! :manage, SegmentDefinition, :message => 'Not authorized as an administrator.'
    @segment_def = SegmentDefinition.find params[:id]
    @segment_members = Identity.where(:session_id => @segment_def.member_ids)
  end

  private

  def segment_definition_params
    params.require(:segment_definition).permit(:name, :event_name)
  end
end

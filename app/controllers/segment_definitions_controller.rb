class SegmentDefinitionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @segment_defs = SegmentDefinition.all
  end

  def new
    @segment_def = SegmentDefinition.new
  end

  def create
    @segment_def = SegmentDefinition.new segment_definition_params
    @segment_def.user_id = current_user.id
    if @segment_def.save
      flash[:success] = "Saved."
      redirect_to segment_definitions_path
    end
  end

  private

  def segment_definition_params
    params.require(:segment_definition).permit(:name, :event_name)
  end
end

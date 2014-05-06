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
    @segment_def = SegmentDefinition.new
    @segment_def.name = segment_definition_params[:name]
    @segment_def.user_id = current_user.id
    if @segment_def.save
      begin
        event_names = segment_definition_params[:event_name]
        event_names.each do |name|
          if name.present? && name != ""
            SegmentEvent.where(:segment_definition_id => @segment_def.id).where(:event_name => name).first_or_create
          end
        end
      rescue Exception => e
        flash[:error] = "There were some errors"
        redirect_to :back
        return
      end
      flash[:success] = "Saved."
      @segment_def.enqueue_recompute
      redirect_to segment_definitions_path
    end
  end

  def show
    authorize! :read, SegmentDefinition, :message => 'Not authorized as an administrator.'
    @segment_def = SegmentDefinition.find params[:id]
    @segment_member_identities = @segment_def.identity_segments.order('entered_at DESC').page(params[:page]).per_page(25)
  end

  private

  def segment_definition_params
    params.require(:segment_definition).permit!
  end
end

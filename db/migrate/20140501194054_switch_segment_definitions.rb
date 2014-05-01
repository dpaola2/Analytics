class SwitchSegmentDefinitions < ActiveRecord::Migration
  def change
    segments = SegmentDefinition.all
    segments.each do |seg_def|
      segment_event = SegmentEvent.new
      segment_event.segment_definition_id = seg_def.id
      segment_event.event_name = seg_def.event_name
      segment_event.save!
    end
  end
end

class SegmentDefinition < ActiveRecord::Base
  belongs_to :user

  def member_ids
    StandardEvent.select('DISTINCT session_id').where(:name => self.event_name).pluck(:session_id)
  end
end

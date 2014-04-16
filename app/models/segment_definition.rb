class SegmentDefinition < ActiveRecord::Base
  belongs_to :user

  def member_ids
    StandardEvent.select('DISTINCT session_id').where(:name => self.event_name).pluck(:session_id)
  end

  def members
    sessions = Session.where(:id => self.member_ids)
    sessions.collect{|s| s.identity}.uniq.select{|i| !i.nil?}
  end
end

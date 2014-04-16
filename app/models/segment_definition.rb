class SegmentDefinition < ActiveRecord::Base
  belongs_to :user

  after_create :enqueue_recompute

  def member_ids
    StandardEvent.select('DISTINCT session_id').where(:name => self.event_name).pluck(:session_id)
  end

  def members
    sessions = Session.where(:id => self.member_ids)
    sessions.collect{|s| s.identity}.uniq.select{|i| !i.nil?}
  end

  def recompute!
    self.member_count = self.members.count
    self.save!
  end

  def enqueue_recompute
    self.delay.recompute!
  end
end

class SegmentDefinition < ActiveRecord::Base
  belongs_to :user
  has_many :identity_segments
  has_many :identities, :through => :identity_segments

  after_create :enqueue_recompute

  def member_session_ids
    # this is where intersection will be done in the future
    StandardEvent.select('DISTINCT session_id').where(:name => self.event_name).pluck(:session_id)
  end

  def member_identities
    sessions = Session.where(:id => self.member_session_ids)
    sessions.collect{|s| s.identity}.uniq.select{|i| !i.nil?}
  end

  def members
    self.identities
  end

  def recompute!
    self.member_identities.each do |identity|
      id_seg = IdentitySegment.where(:segment_definition_id => self.id).where(:left_at => nil).where(:identity_id => identity.id).first_or_initialize
      if id_seg.entered_at.nil?
        id_seg.entered_at = DateTime.now
      end
      id_seg.save!
    end

    self.member_count = member_identities.count
    self.save!
  end

  def enqueue_recompute
    self.delay.recompute!
  end
end

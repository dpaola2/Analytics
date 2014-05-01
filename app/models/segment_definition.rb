class SegmentDefinition < ActiveRecord::Base
  belongs_to :user
  has_many :identity_segments
  has_many :identities, :through => :identity_segments

  has_many :segment_events

  def member_session_ids
    # this is where intersection will be done in the future
    event_names = self.segment_events.collect{|se| se.event_name }
    event_names.collect do |event_name|
      StandardEvent.select('DISTINCT session_id').where(:name => event_name).pluck(:session_id)
    end.flatten.uniq
  end

  def member_identities
    sessions = Session.where(:id => self.member_session_ids)
    sessions.collect{|s| s.identity}.uniq.select{|i| !i.nil?}
  end

  def members
    self.identities
  end

  def members_on_week(week)
    self.identities.joins(:identity_segments).where('identity_segments.left_at IS NULL').where('identity_segments.entered_at > ? AND identity_segments.entered_at < ?', week.beginning_of_week, week.end_of_week)
  end

  def recompute!
    result = Benchmark.measure do
      self.member_identities.each do |identity|
        id_seg = IdentitySegment.where(:segment_definition_id => self.id).where(:left_at => nil).where(:identity_id => identity.id).first_or_initialize
        if id_seg.entered_at.nil?
          id_seg.entered_at = identity.first_event_timestamp(self.segment_events.collect{|s| s.event_name}).timestamp
        end
        id_seg.save!
      end

      self.member_count = member_identities.count
      self.save!
    end
    self.compute_seconds = result.real
    self.save!
  end

  def enqueue_recompute
    self.delay.recompute!
  end

  def self.items_for_select
    SegmentDefinition.all.collect {|s| [s.name, s.id]}
  end
end

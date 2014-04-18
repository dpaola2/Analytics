class Identity < ActiveRecord::Base
  has_many :sessions
  has_many :identity_segments
  has_many :segment_definitions, :through => :identity_segments

  def self.create_from_event!(event)
    identity = Identity.new
    identity.userid = event.to_json['userId']
    identity.email = event.to_json['traits']['email']
    identity.username = event.to_json['traits']['email']
    identity.created = event.to_json['traits']['created']
    identity.save!
    identity
  end

  def session_ids_as_strings
    self.sessions.pluck(:id).collect{|i| i.to_s}
  end

  def standard_events
    StandardEvent.where(:session_id => self.session_ids_as_strings).order('timestamp DESC')
  end

  def first_event_timestamp(event_name)
    StandardEvent.where(:name => event_name).where(:session_id => self.session_ids_as_strings).first
  end
end

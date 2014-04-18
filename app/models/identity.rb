class Identity < ActiveRecord::Base
  has_many :sessions
  has_many :identity_segments

  def self.create_from_event!(event)
    identity = Identity.new
    identity.userid = event.to_json['userId']
    identity.email = event.to_json['traits']['email']
    identity.username = event.to_json['traits']['email']
    identity.created = event.to_json['traits']['created']
    identity.save!
    identity
  end

  def standard_events
    StandardEvent.where(:session_id => self.sessions.pluck(:id).collect{|i| i.to_s}).order('timestamp DESC')
  end
end

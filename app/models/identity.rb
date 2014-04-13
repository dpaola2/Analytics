class Identity < ActiveRecord::Base

  def self.create_from_event!(event)
    session_id = event.to_json['sessionId']
    identity = Identity.where(:session_id => session_id).first_or_initialize
    identity.session_id = session_id
    identity.userid = event.to_json['userId']
    identity.email = event.to_json['traits']['email']
    identity.username = event.to_json['traits']['email']
    identity.created = event.to_json['traits']['created']
    identity.save!
  end

  def to_param
    self.session_id
  end
end

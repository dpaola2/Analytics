class Identity < ActiveRecord::Base
  has_many :sessions

  def self.create_from_event!(event)
    identity = Identity.new
    identity.userid = event.to_json['userId']
    identity.email = event.to_json['traits']['email']
    identity.username = event.to_json['traits']['email']
    identity.created = event.to_json['traits']['created']
    identity.save!
    identity
  end

  def to_param
    self.session_id
  end
end

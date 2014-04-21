class Session < ActiveRecord::Base
  belongs_to :identity
  
  def self.create_from_event!(event)
    unique_id = event.to_json['sessionId']
    session = Session.where(:unique_id => unique_id).first_or_initialize

    # find all identities with this email and point this session to them
    dupes = Session.includes(:identity).where("email is not NULL and email != ''").where('identities.email = ?', event.to_json['traits']['email'])
    if dupes.count < 1
      new_identity = Identity.create_from_event!(event)
      session.identity_id = new_identity.id
    else
      dupes.each do |dupe_session|
        session.identity_id = dupe_session.identity_id
      end
    end
    session.save!
  end
end

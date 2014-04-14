class StandardEvent < ActiveRecord::Base
  belongs_to :event
  
  def self.create_from_event!(event)
    event_id = event.id
    if StandardEvent.find_by_event_id(event_id).nil? # has this event already been created?
      name = event.to_json['event']
      timestamp = event.to_json['timestamp']
      session_id = event.to_json['sessionId']
      se = StandardEvent.create!(:name => name, :timestamp => timestamp, :event_id => event_id, :session_id => session_id)
      return se
    end
  end

  def reextract!
    self.name = self.event.to_json['event']
    self.timestamp = self.event.to_json['timestamp']
    self.session_id = self.event.to_json['sessionId']
    self.save!
  end

  def to_param
    self.name
  end
end

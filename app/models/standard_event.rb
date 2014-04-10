class StandardEvent < ActiveRecord::Base
  def self.create_from_event!(event)
    event_id = event.id
    if StandardEvent.find_by_event_id(event_id).nil? # has this event already been created?
      name = event.to_json['event']
      timestamp = event.to_json['timestamp']
      se = StandardEvent.create!(:name => name, :timestamp => timestamp, :event_id => event_id)
    end
  end
end

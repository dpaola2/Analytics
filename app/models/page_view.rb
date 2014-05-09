class PageView < ActiveRecord::Base
  belongs_to :event
  def self.create_from_event!(event)
    event_id = event.id
    if PageView.find_by_event_id(event_id).nil? # has this pageview been created already?
      as_json = event.to_json
      timestamp = as_json['timestamp']
      path = as_json['properties']['path']
      title = as_json['properties']['title']
      pv = PageView.create!(
        :timestamp => timestamp,
        :path => path,
        :title => title,
        :event_id => event_id
        )
    end
  end
end

class Event < ActiveRecord::Base
  CLASSMAP = {
    'Track' => StandardEvent,
    'Page' => PageView,
    'Identify' => Session
  }

  after_create :background_extract

  def to_json
    if self.properties.nil?
      JSON.parse(self.blob)
    else
      self.properties
    end
  end

  def action
    self.to_json['action']
  end

  def extract!
    klass = CLASSMAP[self.action]
    if klass
      klass.create_from_event!(self)
    end
  end

  def background_extract
    self.delay.extract!
    self.delay.parse
  end

  def parse
    self.properties = self.to_json
    self.json_properties = self.blob
    self.save!
  end

  def source_string
    identities = Identity.where(:userid => self.properties['userId']).all
    sessions = Session.where(:unique_id => self.properties['sessionId']).all
    sessions = (sessions + identities.collect {|i| i.sessions}).flatten.uniq
    identities = (identities + sessions.collect{|s| s.identity}).flatten.uniq
    pageviews = identities.collect {|i| PageView.joins("INNER JOIN events ON events.id = page_views.event_id").where("events.properties->'userId' = ? OR events.properties->'sessionId' IN (?)", i.userid, i.sessions.collect {|s| s.unique_id}.join(",")).all }.flatten
  end
end

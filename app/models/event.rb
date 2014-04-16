class Event < ActiveRecord::Base
  CLASSMAP = {
    'Track' => StandardEvent,
    'Page' => PageView,
    'Identify' => Session
  }

  after_save :background_extract

  def to_json
    JSON.parse(self.blob)
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
  end

  def self.reextract_all # THIS IS EXPENSIVE
    Event.all.each {|e| e.background_extract }
  end
end

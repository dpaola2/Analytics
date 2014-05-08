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
    self.save!
  end

  def source_string
    if self.properties['options']
      opts = eval(self.properties['options'])
      source = opts['source']
      medium = opts['medium']
      campaign = opts['medium']
      "#{source} / #{campaign} / #{medium}"
    else
      nil
    end
  end
end

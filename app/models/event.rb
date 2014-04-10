class Event < ActiveRecord::Base
  CLASSMAP = {
    'Track' => StandardEvent
  }

  after_save :extract!

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
end

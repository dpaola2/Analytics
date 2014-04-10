class Event < ActiveRecord::Base

  def to_json
    JSON.parse(self.blob)
  end

  def action
    self.to_json['action']
  end
end

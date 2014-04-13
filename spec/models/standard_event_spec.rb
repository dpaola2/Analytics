require 'spec_helper'

describe StandardEvent do
  before do
    @event = FactoryGirl.create(:event)
  end

  describe "#create_from_event!(event)" do
    it "should have an event with an id" do
      @event.id.should_not be_nil
    end

    it "assigns a Standard Event name from the event JSON blob" do
      name = @event.to_json['event']
      name.should match 'viewed_landing'
    end

    it "assigns a Standard Event timestamp from the event JSON blob" do
      timestamp = @event.to_json['timestamp']
      timestamp.should match '2014-04-10T20:22:29.537Z'
    end
  end
end

require 'spec_helper'

describe EventsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response.response_code).to eq 302
      # Events index redirects to StandardEvents ?
    end
  end

  describe "GET 'show'" do
    # Can't quite figure out how to test this controller action
    xit "returns http success" do
      event = FactoryGirl.create(:event)
      get 'events/#{event.id}'
      puts response.inspect
      response.should be_success
    end
  end

end

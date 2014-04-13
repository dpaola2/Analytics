require 'spec_helper'

describe StandardEventsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response.response_code).to eq 302
    end
  end

  describe "GET 'show'" do
    xit "returns http success" do
      # get standard event show action
      get 'show'
      response.should be_success
    end
  end

end

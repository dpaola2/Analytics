require 'spec_helper'

describe PageViewsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response.response_code).to eq 302
    end
  end

end

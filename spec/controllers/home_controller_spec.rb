require 'spec_helper'
require 'rails_helper'

describe HomeController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end

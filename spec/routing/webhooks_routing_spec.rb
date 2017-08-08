require "rails_helper"

RSpec.describe Api::V1::WebhooksController, type: :routing do
  describe "V1 routing" do

    it "routes to #index" do
      expect(:get => "/v1/webhooks").to route_to("api/v1/webhooks#index")
    end


    it "routes to #show" do
      expect(:get => "/v1/webhooks/1").to route_to("api/v1/webhooks#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/v1/webhooks").to route_to("api/v1/webhooks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/webhooks/1").to route_to("api/v1/webhooks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/webhooks/1").to route_to("api/v1/webhooks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/webhooks/1").to route_to("api/v1/webhooks#destroy", :id => "1")
    end

  end
end

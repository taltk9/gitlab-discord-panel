require 'rails_helper'

RSpec.describe "Webhooks", type: :request do
  describe "GET /v1/webhooks" do
    it "works! (now write some real specs)" do
      get v1_webhooks_path
      expect(response).to have_http_status(200)
    end
  end
end

require 'rails_helper'

RSpec.describe "Webhooks", type: :request do
  describe "GET /v1/webhooks" do
    before do
      create_list(:webhook, 10)
      get v1_webhooks_path
    end

    it "returns 200 HTTP status" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the right amout of webhooks" do
      expect(json.length).to eq(10)
    end
  end

  describe "POST /v1/webhooks" do
    let(:webhook) { attributes_for(:webhook) }

    before { post v1_webhooks_path, params: { webhook: webhook } }

    context "when create is successful" do
      it "returns 201 HTTP status" do
        expect(response).to have_http_status(:created)
      end

      it "returns the created webhook values" do
        expect(json["name"]).to eq(webhook[:name])
        expect(json["project_name"]).to eq(webhook[:project_name])
        expect(json["url"]).to eq(webhook[:url])
      end

      it "returns the expected webhook response properties" do
        expected_results = %w(id project_name name url created_at updated_at)
        expect(json.keys).to eq(expected_results)
      end
    end

    context "when create request has failed" do
      let(:webhook) { attributes_for(:invalid_webhook) }

      it "returns 422 HTTP status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the webhook properties that are invalid" do
        expected_results = ["name", "project_name", "url"]
        expect(json.keys).to eq(expected_results)
      end

      it "returns the expected error messages for blank values" do
        expected_messages = {
          "name" => ["can't be blank"],
          "project_name" => ["can't be blank"],
          "url" => ["can't be blank", "is invalid"]
        }
        expect(json).to eq(expected_messages)
      end

      context "and URL isn't blank but invalid" do
        let(:webhook) { attributes_for(:webhook, url: 'www.invalid.url.cause.need.http') }

        it "returns the expected error message" do
          expected_message = { "url" => ["is invalid"] }
          expect(json).to eq(expected_message)
        end
      end
    end
  end

  describe "GET /v1/webhooks/:id" do
    let(:webhook) { create(:webhook) }

    before { get v1_webhook_path webhook }

    context "when show is successful" do
      it "returns 200 HTTP status" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the desired webhook" do
        expect(json["id"]).to eq(webhook["id"])
      end
    end

    context "when request has failed" do
      let(:webhook) { attributes_for(:webhook, id: "223") }

      it "returns 404 not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PATCH/PUT /v1/webhooks/:id" do
    let(:webhook) { create(:webhook) }
    let(:name) { "edited-webhook" }
    let(:params) { { webhook: { name: name } } }

    before { put v1_webhook_path(webhook), params: params }

    context "when update is successful" do
      it "returns 200 HTTP status" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the desired webhook updated" do
        expect(json["name"]).to eq(name)
      end
    end

    context "when update has failed" do
      let(:name) { "" }

      it "returns 422 HTTP status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the expected error messages for blank values" do
        expected_messages = {
          "name" => ["can't be blank"],
        }
        expect(json).to eq(expected_messages)
      end

      context "and URL isn't blank but invalid" do
        let(:url) { "www.invalid.url.cause.need.http" }
        let(:params) { { webhook: { url: url } } }

        it "returns the expected error message" do
          expected_message = { "url" => ["is invalid"] }
          expect(json).to eq(expected_message)
        end
      end
    end
  end

  describe "DELETE /v1/webhooks/:id" do
    let(:webhook) { create(:webhook) }

    before { delete v1_webhook_path webhook }

    context "when delete is successful" do
      it "returns 204 HTTP status" do
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when delete has failed" do
      let(:webhook) { attributes_for(:webhook, id: 3242) }

      it "returns 404 HTTP status" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

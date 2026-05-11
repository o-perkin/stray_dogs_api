require 'rails_helper'

RSpec.describe "AI agent status", type: :request do
  describe "GET /api/v1/ai_agent_status" do
    it "returns the OpenClaw status payload" do
      get "/api/v1/ai_agent_status"

      expect(response).to have_http_status(200)
      expect(json["status"]).to eq("ok")
      expect(json["source"]).to eq("openclaw")
    end
  end
end

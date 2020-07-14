require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#copyright_generator" do
    it "returns string" do
      expect(copyright_generator).to eq("&copy; 2020 | <b>Alex Perkin</b> All rights reserved")
    end
  end
end
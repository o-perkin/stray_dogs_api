require "rails_helper"

RSpec.describe DogsHelper, type: :helper do
  describe ".sortable" do
    it "returns link when all parameters exist" do
      call = helper.sortable("breed_id", "breed", "index")
      result = "<a class=\"flex-sm-fill text-sm-center nav-link\" data-remote=\"true\" href=\"/dogs?direction=asc&amp;sort=breed_id\">breed</a>"
      expect(call).to eq(result)
    end

    it "returns link with dropdown-toggle active classes if column == sort_column" do
      call = helper.sortable("created_at", "Created", "index")
      result = "<a class=\"flex-sm-fill text-sm-center nav-link dropdown-toggle active\" data-remote=\"true\" href=\"/dogs?direction=asc&amp;sort=created_at\">Created</a>"
      expect(call).to eq(result)
    end

    it "returns link with dropdown-toggle active classes if column == sort_column" do
      call = helper.sortable("created_at", "Created", "index")
      result = "<a class=\"flex-sm-fill text-sm-center nav-link dropdown-toggle active\" data-remote=\"true\" href=\"/dogs?direction=asc&amp;sort=created_at\">Created</a>"
      expect(call).to eq(result)
    end
  end
end
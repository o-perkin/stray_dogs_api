require "rails_helper"

RSpec.describe DogsHelper, type: :helper do

  context "Public methods" do 
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

      it "returns link with my_list_path if page is not index" do
        call = helper.sortable("breed_id", "breed", "my_list")
        result = "<a class=\"flex-sm-fill text-sm-center nav-link\" data-remote=\"true\" href=\"/my_list?direction=asc&amp;sort=breed_id\">breed</a>"
        expect(call).to eq(result)
      end

      it "returns link with my_list_path and with active class if page is not index and column == sort_column" do
        call = helper.sortable("created_at", "Created", "my_list")
        result = "<a class=\"flex-sm-fill text-sm-center nav-link dropdown-toggle active\" data-remote=\"true\" href=\"/my_list?direction=asc&amp;sort=created_at\">Created</a>"
        expect(call).to eq(result)
      end
    end
  end

  context "Private methods" do 
    describe ".set_path_for_sorting" do
      it "returns dogs path with direction asc and sort created_at" do
        call = helper.send(:set_path_for_sorting, "created_at", "index")
        result = "/dogs?direction=asc&sort=created_at"
        expect(call).to eq(result)
      end
      it "returns my_list path with direction asc and sort created_at" do
        call = helper.send(:set_path_for_sorting, "created_at", "my_list")
        result = "/my_list?direction=asc&sort=created_at"
        expect(call).to eq(result)
      end
      it "returns dogs path with direction desc and sort created_at" do
        call = helper.send(:set_path_for_sorting, "created_at", "index")
        result = "/dogs?direction=asc&sort=created_at"
        expect(call).to eq(result)
      end
      it "returns dogs path with direction desc and sort breed_id" do
        call = helper.send(:set_path_for_sorting, "breed_id", "index")
        result = "/dogs?direction=asc&sort=breed_id"
        expect(call).to eq(result)
      end
      it "returns my_list path with direction desc and sort created_at" do
        call = helper.send(:set_path_for_sorting, "created_at", "my_list")
        result = "/my_list?direction=asc&sort=created_at"
        expect(call).to eq(result)
      end
      it "returns my_list path with direction desc and sort breed_id" do
        call = helper.send(:set_path_for_sorting, "breed_id", "my_list")
        result = "/my_list?direction=asc&sort=breed_id"
        expect(call).to eq(result)
      end
    end
    describe ".set_css_class" do
      it "returns flex-sm-fill regular css class if column != sort_column" do
        call = helper.send(:set_css_class, "breed_id")
        result = "flex-sm-fill text-sm-center nav-link"
        expect(call).to eq(result)
      end
      it "returns active class if column == sort_column" do
        call = helper.send(:set_css_class, "created_at")
        result = "flex-sm-fill text-sm-center nav-link dropdown-toggle active"
        expect(call).to eq(result)
      end
    end
    describe ".set_sorting_direction" do
      it "returns asc if column == sort_column && sort_direction == desc" do
        call = helper.send(:set_sorting_direction, "created_at")
        result = "asc"
        expect(call).to eq(result)
      end
      it "returns asc if column != sort_column && sort_direction == desc" do
        call = helper.send(:set_sorting_direction, "breed_id")
        result = "asc"
        expect(call).to eq(result)
      end
      it "returns desc if column == sort_column && sort_direction == asc" do
        allow(helper).to receive(:sort_direction) {"asc"}
        call = helper.send(:set_sorting_direction, "created_at")
        result = "desc"
        expect(call).to eq(result)
      end
    end
    describe ".set_dropup_css_class" do
      it "returns dropup if sort_direction == desc" do
        call = helper.send(:set_dropup_css_class)
        result = "dropup"
        expect(call).to eq(result)
      end
      it "returns empty string if sort_direction == asc" do
        allow(helper).to receive(:sort_direction).and_return("asc")
        call = helper.send(:set_dropup_css_class)
        result = ""
        expect(call).to eq(result)
      end
    end
    describe ".sort_column" do
      it "returns created_at if Dogs column names don't include params[:sort]" do
        call = helper.send(:sort_column)
        result = "created_at"
        expect(call).to eq(result)
      end
    end
    describe ".sort_direction" do
      it "returns desc if params[:direction] don't include asc or desc" do
        call = helper.send(:sort_direction)
        result = "desc"
        expect(call).to eq(result)
      end
    end
  end
end
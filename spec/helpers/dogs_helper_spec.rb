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

    describe ".send_letters" do
      it "calls new_dog_email_method" do
        user = create(:user)
        dog = create(:dog)
        mail = helper.send_letters_after_dog_creation(user, dog, [])
        expect(mail.subject).to eq("Ви додали собаку!")
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(["work.perkin@gmail.com"])
      end

      it "calls available_subscription_email and send_notification_to_subscriber methods" do
        user = create(:user)
        dog = create(:dog)
        subscription = create(:subscription)
        mail = helper.send_letters_after_dog_creation(user, dog, [subscription])
        expect(mail.subject).to eq("На сайті з'явилась потрібна вам собака!")
        expect(mail.to).to eq([subscription.subscribe.user.email])
        expect(mail.from).to eq(["work.perkin@gmail.com"])
      end
    end
  end

  context "Private methods" do 
    describe ".define_path_for_sortable" do
      it "returns dogs path with direction asc and sort created_at" do
        call = helper.send(:define_path_for_sortable, "created_at", "asc", "index")
        result = "/dogs?direction=asc&sort=created_at"
        expect(call).to eq(result)
      end
      it "returns my_list path with direction asc and sort created_at" do
        call = helper.send(:define_path_for_sortable, "created_at", "asc", "my_list")
        result = "/my_list?direction=asc&sort=created_at"
        expect(call).to eq(result)
      end
      it "returns dogs path with direction desc and sort created_at" do
        call = helper.send(:define_path_for_sortable, "created_at", "desc", "index")
        result = "/dogs?direction=desc&sort=created_at"
        expect(call).to eq(result)
      end
      it "returns dogs path with direction desc and sort breed_id" do
        call = helper.send(:define_path_for_sortable, "breed_id", "desc", "index")
        result = "/dogs?direction=desc&sort=breed_id"
        expect(call).to eq(result)
      end
      it "returns my_list path with direction desc and sort created_at" do
        call = helper.send(:define_path_for_sortable, "created_at", "desc", "my_list")
        result = "/my_list?direction=desc&sort=created_at"
        expect(call).to eq(result)
      end
      it "returns my_list path with direction desc and sort breed_id" do
        call = helper.send(:define_path_for_sortable, "breed_id", "desc", "my_list")
        result = "/my_list?direction=desc&sort=breed_id"
        expect(call).to eq(result)
      end
    end
    describe ".define_css_class" do
      it "returns flex-sm-fill regular css class if column != sort_column" do
        call = helper.send(:define_css_class, "breed_id")
        result = "flex-sm-fill text-sm-center nav-link"
        expect(call).to eq(result)
      end
      it "returns active class if column == sort_column" do
        call = helper.send(:define_css_class, "created_at")
        result = "flex-sm-fill text-sm-center nav-link dropdown-toggle active"
        expect(call).to eq(result)
      end
    end
    describe ".define_sorting_direction" do
      it "returns asc if column == sort_column && sort_direction == desc" do
        call = helper.send(:define_sorting_direction, "created_at")
        result = "asc"
        expect(call).to eq(result)
      end
      it "returns asc if column != sort_column && sort_direction == desc" do
        call = helper.send(:define_sorting_direction, "breed_id")
        result = "asc"
        expect(call).to eq(result)
      end
      it "returns desc if column == sort_column && sort_direction == asc" do
        allow(helper).to receive(:sort_direction) {"asc"}
        call = helper.send(:define_sorting_direction, "created_at")
        result = "desc"
        expect(call).to eq(result)
      end
    end
    describe ".define_dropup_css_class" do
      it "returns dropup if sort_direction == desc" do
        call = helper.send(:define_dropup_css_class)
        result = "dropup"
        expect(call).to eq(result)
      end
      it "returns empty string if sort_direction == asc" do
        allow(helper).to receive(:sort_direction).and_return("asc")
        call = helper.send(:define_dropup_css_class)
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
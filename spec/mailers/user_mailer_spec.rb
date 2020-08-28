require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe "email_confirmation_of_created_dog" do 
    let!(:user) { create(:user, email: "email@gmail.com") }
    let!(:mail) { UserMailer.email_confirmation_of_created_dog(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Ви додали собаку!")
      expect(mail.to).to eq(["email@gmail.com"])
      expect(mail.from).to eq(["work.perkin@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(user.first_name)
      expect(mail.body.encoded).to match("Have a great day!")
    end
  end

  describe "email_that_dog_is_wanted" do
    let!(:user) { create(:user, email: "email2@gmail.com") }
    let!(:subscription) { create(:subscription) }
    let!(:mail) { UserMailer.email_that_dog_is_wanted(user, [subscription]) }

    it "renders the headers" do
      expect(mail.subject).to eq("На сайті вже шукають вашу собаку!")
      expect(mail.to).to eq(["email2@gmail.com"])
      expect(mail.from).to eq(["work.perkin@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(user.first_name)
      expect(mail.body.encoded).to match(subscription.subscribe.user.first_name)
      expect(mail.body.encoded).to match(subscription.subscribe.user.email)
    end
  end

  describe "email_subscription_confirmation" do
    let!(:user) { create(:user, email: "email3@gmail.com") }
    let!(:dog) { create(:dog) }
    let!(:subscription) { create(:subscription, breed_id: dog.breed_id, city_id: dog.city_id) }
    let!(:mail) { UserMailer.email_subscription_confirmation(user, [subscription]) }

    it "renders the headers" do
      expect(mail.subject).to eq("Ви підписались!")
      expect(mail.to).to eq(["email3@gmail.com"])
      expect(mail.from).to eq(["work.perkin@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(user.first_name)
      expect(mail.body.encoded).to match(dog.breed.name)
      expect(mail.body.encoded).to match(dog.city.name)
    end
  end

  describe "email_that_dog_appeared" do
    let!(:subscription) { create(:subscription) }
    let!(:user) { create(:user) }
    let!(:dog) { create(:dog, user_id: user.id) }
    let!(:mail) { UserMailer.email_that_dog_appeared( user, [subscription]) }

    it "renders the headers" do
      expect(mail.subject).to eq("На сайті з'явилась потрібна вам собака!")
      expect(mail.to).to eq([subscription.subscribe.user.email])
      expect(mail.from).to eq(["work.perkin@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(subscription.subscribe.user.first_name)
      expect(mail.body.encoded).to match(dog.name)
    end
  end


end
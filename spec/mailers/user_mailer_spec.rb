require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe "new_dog_email" do
    let!(:user) { create(:user, email: "email@gmail.com") }
    let!(:mail) { UserMailer.new_dog_email(user) }

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

  describe "available_subscription_email" do
    let!(:user) { create(:user, email: "email2@gmail.com") }
    let!(:subscription) { create(:subscription) }
    let!(:mail) { UserMailer.available_subscription_email(user, [subscription]) }

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

  describe "subscription_email" do
    let!(:user) { create(:user, email: "email3@gmail.com") }
    let!(:dog) { create(:dog) }
    let!(:mail) { UserMailer.subscription_email(user, {breed: {}, city: {}, age: {}}, [[dog]]) }

    it "renders the headers" do
      expect(mail.subject).to eq("Ви підписались!")
      expect(mail.to).to eq(["email3@gmail.com"])
      expect(mail.from).to eq(["work.perkin@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(user.first_name)
      expect(mail.body.encoded).to match(dog.breed.name)
      expect(mail.body.encoded).to match(dog.city.name)
      expect(mail.body.encoded).to match(dog.age.years)
    end
  end

  describe "send_notification_to_subscriber" do
    let!(:subscription) { create(:subscription) }
    let!(:dog) { create(:dog) }
    let!(:mail) { UserMailer.send_notification_to_subscriber([subscription], dog) }

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
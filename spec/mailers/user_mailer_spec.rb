require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe "email_after_creating_dog" do 
    let!(:user) { create(:user, email: "email@gmail.com") }
    let!(:mail) { UserMailer.email_after_creating_dog(user) }

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

  describe "email_if_dog_already_wanted" do
    let!(:user) { create(:user, email: "email2@gmail.com") }
    let!(:subscription) { create(:subscription) }
    let!(:mail) { UserMailer.email_if_dog_already_wanted(user, [subscription]) }

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

  describe "email_after_subscribing" do
    let!(:user) { create(:user, email: "email3@gmail.com") }
    let!(:dog) { create(:dog) }
    let!(:subscription) { create (:subscription) }
    let!(:mail) { UserMailer.email_after_subscribing(user, [subscription]) }

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

  describe "email_if_dog_appeared" do
    let!(:subscription) { create(:subscription) }
    let!(:dog) { create(:dog) }
    let!(:mail) { UserMailer.email_if_dog_appeared([subscription], dog) }

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
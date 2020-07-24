require "rails_helper"

RSpec.describe DogsHelper, type: :helper do
  describe ".send_letters_after_subscribing" do
    it "calls subscription_email method" do
      user = create(:user)
      dog = create(:dog)
      mail = helper.send_letters_after_subscribing(user, {breed: {}, city: {}, age: {}}, [[dog]])
      expect(mail.subject).to eq("Ви підписались!")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["work.perkin@gmail.com"])
    end
  end
end
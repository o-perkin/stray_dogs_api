require 'rails_helper'

RSpec.describe Subscription, :type => :model do
  context "Associations" do
    it { should belong_to(:subscribe) }
    it { should belong_to(:breed) }
    it { should belong_to(:city) }
  end
end
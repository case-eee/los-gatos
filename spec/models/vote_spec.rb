require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:cat) { Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "hola i'm a cat")}
  let(:vote) { cat.votes.create!(category: "ZOMG! Cute!", IP_Address: Faker::Internet.ip_v6_address)}

  it { expect(vote).to belong_to(:cat)}
  it { expect(vote).to validate_presence_of(:category)}
  it { expect(vote).to validate_presence_of(:IP_Address)}

end

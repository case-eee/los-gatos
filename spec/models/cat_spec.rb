require 'rails_helper'

RSpec.describe Cat, type: :model do
  let(:cat) { Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "hola i'm a cat")}

  it { expect(cat).to have_many(:votes)}
  it { expect(cat).to validate_presence_of(:url)}
  it { expect(cat).to validate_presence_of(:description)}

end

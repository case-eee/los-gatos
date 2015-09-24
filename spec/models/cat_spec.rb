require 'rails_helper'

RSpec.describe Cat, type: :model do
  let!(:cat) { Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "hola i'm a cat")}
  let!(:cat_two) { Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "i'm the second cat")}
  let!(:cat_three) { Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "i'm the third cat")}


  it { expect(cat).to have_many(:votes)}
  it { expect(cat).to validate_presence_of(:url)}
  it { expect(cat).to validate_presence_of(:description)}

  describe ".generate_random" do
    it "retrieves two random cat's from the database" do
      expect(Cat.generate_random.count).to eq 2
    end
  end

  describe "#amazing_count" do
    it "returns zero when a cat has received no votes" do
      expect(cat.amazing_count).to eq 0
    end

    it "returns the count of amazing votes a cat has received" do
      2.times do
        cat.votes.create!(category: "Amazing! So Beautiful!", IP_Address: Faker::Internet.ip_v6_address)
      end
      expect(cat.amazing_count).to eq 2
    end
  end

  describe "#cute_count" do
    it "returns zero when a cat has received no votes" do
      expect(cat.cute_count).to eq 0
    end

    it "returns the count of amazing votes a cat has received" do
      2.times do
        cat.votes.create!(category: "ZOMG! Cute!", IP_Address: Faker::Internet.ip_v6_address)
      end
      expect(cat.cute_count).to eq 2
    end
  end

  describe "#amazing_count" do
    it "returns zero when a cat has received no votes" do
      expect(cat.amazing_count).to eq 0
    end

    it "returns the count of amazing votes a cat has received" do
      4.times do
        cat.votes.create!(category: "Amazing! So Beautiful!", IP_Address: Faker::Internet.ip_v6_address)
      end
      expect(cat.amazing_count).to eq 4
    end
  end

  describe ".sort_by_amazing" do
    before :each do
      2.times do
        cat_two.votes.create!(category: "Amazing! So Beautiful!", IP_Address: Faker::Internet.ip_v6_address)
      end
      cat.votes.create!(category: "Amazing! So Beautiful!", IP_Address: Faker::Internet.ip_v6_address)
    end

    it "sorts the cats accordingly" do
      expect(Cat.sort_by_amazing).to match_array([cat_two, cat, cat_three])
    end
  end

  describe ".sort_by_cute" do
    before :each do
      2.times do
        cat.votes.create!(category: "ZOMG! Cute!", IP_Address: Faker::Internet.ip_v6_address)
      end
      cat_two.votes.create!(category: "ZOMG! Cute!", IP_Address: Faker::Internet.ip_v6_address)
    end
    it "sorts the cats accordingly" do
      expect(Cat.sort_by_cute).to match_array([cat, cat_two, cat_three])
    end
  end


end

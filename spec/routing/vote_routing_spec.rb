require "spec_helper"

describe Cats::VotesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/cats/votes").to route_to("cats/votes#index")
    end

    it "routes to #create_amazing" do
      expect(post: "/cats/votes/create_amazing").to route_to("cats/votes#create_amazing")
    end

    it "routes to #create_cute" do
      expect(post: "/cats/votes/create_cute").to route_to("cats/votes#create_cute")
    end
  end
end
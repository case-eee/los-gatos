require "spec_helper"

describe Admin::CatsController do
  describe "routing" do

    it "routes to #cute_votes" do
      expect(get: "/admin/cats/cute_votes").to route_to("admin/cats#cute_votes")
    end

    it "routes to #amazing_votes" do
      expect(get: "/admin/cats/amazing_votes").to route_to("admin/cats#amazing_votes")
    end

    it "routes to #index" do
      expect(get: "/admin/cats").to route_to("admin/cats#index")
    end

    it "routes to #new" do
      expect(get: "/admin/cats/new").to route_to("admin/cats#new")
    end

    it "routes to #show" do
      expect(get: "/admin/cats/1").to route_to("admin/cats#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/cats/1/edit").to route_to("admin/cats#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/admin/cats").to route_to("admin/cats#create")
    end

    it "routes to #update" do
      expect(put: "/admin/cats/1").to route_to("admin/cats#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/cats/1").to route_to("admin/cats#destroy", id: "1")
    end

  end
end
require "spec_helper"

describe Admin::SessionsController do
  describe "routing" do
    it "routes to #login" do
      expect(get: "/admin/login").to route_to("admin/sessions#login")
    end

    it "routes to #logout" do
      expect(delete: "/admin/logout").to route_to("admin/sessions#logout")
    end

    it "routes to #create" do
      expect(post: "/admin/sessions").to route_to("admin/sessions#create")
    end
  end
end
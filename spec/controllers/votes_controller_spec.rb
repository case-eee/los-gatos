require "rails_helper"

RSpec.describe Cats::VotesController, :type => :controller do
  before :each do
    @cat = Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "hola i'm a cat")
    @cat_two = Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "i'm the second cat")
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns @cats" do
      get :index
      expect(assigns(:cats).count).to eq(2)
      expect(assigns(:cats).first).to be_instance_of(Cat)
    end
  end

  describe "POST #create_amazing" do
    it "increases the number of amazing votes" do
      expect{ post :create_amazing, id: @cat.id}.to change{ Vote.where(category: "Amazing! So Beautiful!").count }.by(1)
    end

    it "should redirect to the index page" do
      post :create_amazing, id: @cat.id
      expect(response).to redirect_to cats_votes_path
    end
  end

  describe "POST #create_cute" do
    it "increases the number of cute votes" do
      expect{ post :create_cute, id: @cat.id}.to change{ Vote.where(category: "ZOMG! Cute!").count }.by(1)
    end

    it "should redirect to the index page" do
      post :create_amazing, id: @cat.id
      expect(response).to redirect_to cats_votes_path
    end
  end

end
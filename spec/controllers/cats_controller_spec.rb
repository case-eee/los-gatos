require "rails_helper"

RSpec.describe Admin::CatsController, :type => :controller do

  describe "GET #index" do
    before :each do
      # allow(controller).to receive(:require_login)
      @cat = Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "hola i'm a cat")
      @cat_two = Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "i'm the second cat")
      @cat.votes.create!(category: "Amazing! So Beautiful!", IP_Address: Faker::Internet.ip_v6_address)
      @cat_two.votes.create!(category: "ZOMG! Cute!", IP_Address: Faker::Internet.ip_v6_address)
    end

    it "responds successfully with an HTTP 200 status code if user is logged in" do
      allow(controller).to receive(:require_login)
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "responds unsuccessfully with an HTTP 302 status code if user is not logged in" do
      get :index
      expect(response).to_not be_success
      expect(response).to have_http_status(302)
    end

    it "renders the index template" do
      allow(controller).to receive(:require_login)
      get :index
      expect(response).to render_template("index")
    end

    context "when admin arrives on page without sorting" do
      it "assigns @cats" do
        allow(controller).to receive(:require_login)
        get :index
        expect(assigns(:cats)).to eq([@cat, @cat_two])
      end
    end

    context "when sorted by amazingness" do
      it "assigns @cats to a sorted list by most amazing votes" do
        allow(controller).to receive(:require_login)
        get :index, {:sort => "amazing"}
        expect(assigns(:cats)).to eq([@cat, @cat_two])
      end
    end

    context "when sorted by cuteness" do
      it "assigns @cats to a sorted list by most cuteness votes" do
        allow(controller).to receive(:require_login)
        get :index, {:sort => "cute"}
        expect(assigns(:cats)).to eq([@cat_two, @cat])
      end
    end
  end


  describe "GET #new" do
    it "assigns @cat to a new Cat object" do
      allow(controller).to receive(:require_login)
      get :new
      expect(assigns(:cat)).to be_instance_of(Cat)
    end

    it "renders the new template" do
      allow(controller).to receive(:require_login)
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    before :each do
      allow(controller).to receive(:require_login)
    end

    context "when valid params are passed" do
      let(:valid_cat) { Cat.new(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "hola i'm a cat")}
      it "creates a new cat" do
        expect { post :create, cat: { url: valid_cat.url, description: valid_cat.description } }.to change{ Cat.all.count }.by(1)
      end

      it "assigns a newly created cat as @cat" do
        # allow(controller).to receive(:require_login)
        post :create, cat: { url: valid_cat.url, description: valid_cat.description }
        expect(assigns(:cat)).to eq(Cat.last)
      end

      it "redirects to the index view" do
        # allow(controller).to receive(:require_login)
        post :create, cat: { url: valid_cat.url, description: valid_cat.description }
        expect(response).to redirect_to action: :index
      end
    end

    context "when invalid params are passed" do
      let(:invalid_cat) { Cat.create(url: "", description: "hola i'm a cat")}
      it "does not create a new cat" do
        # allow(controller).to receive(:require_login)
        expect { post :create, cat: { url: invalid_cat.url, description: invalid_cat.description } }.to change{ Cat.all.count }.by(0)
      end

      it "assigns a newly created but unsaved cat as @cat" do
        # allow(controller).to receive(:require_login)
        post :create, cat: { url: invalid_cat.url, description: invalid_cat.description }
        expect(assigns(:cat).id).to eq(nil)
      end

      it "re-renders the new view" do
        # allow(controller).to receive(:require_login)
        post :create, cat: { url: invalid_cat.url, description: invalid_cat.description }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    before :each do
      allow(controller).to receive(:require_login)
      @cat = Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "hola i'm a cat")
    end

    it "assigns the requested cat as @cat" do
      get :show, { id: @cat.id }
      expect(assigns(:cat)).to eq(@cat)
    end

    it "renders the show view" do
      get :show, {id: @cat.id}
      expect(response).to render_template(:show)
    end
  end

   describe "DELETE #destroy" do
    before :each do
      allow(controller).to receive(:require_login)
      @cat = Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "hola i'm a cat")
    end

    it "assigns the requested cat as @cat" do
      delete :destroy, { id: @cat.id }
      expect(assigns(:cat)).to eq(@cat)
    end

    it "destroys the requested cat" do
      expect { delete :destroy, id: @cat.id }.to change(Cat, :count).by(-1)
    end

    it "redirects to the index cats view" do
      delete :destroy, { id: @cat.id }
      expect(response).to redirect_to action: :index
    end
  end

  describe "GET #edit" do
    before :each do
      allow(controller).to receive(:require_login)
      @cat = Cat.create!(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "hola i'm a cat")
    end

    it "assigns the requested cat as @cat" do
      get :edit, { id: @cat.id }
      expect(assigns(:cat)).to eq(@cat)
    end

    it "renders the edit view" do
      get :edit, {id: @cat.id}
      expect(response).to render_template(:edit)
    end
  end


  describe "PATCH #update" do
    context "when valid parameters are passed" do
      before :each do
        @valid_cat = Cat.create(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "hola i'm a cat")
        allow(controller).to receive(:require_login)
        put :update, id: @valid_cat.id, :cat => @valid_cat.attributes = { url: "http://new-url.com", description: "New description here!" }
      end

      it "updates the cat based on the new params" do
        expect(@valid_cat.url).to eq("http://new-url.com")
      end

      it "assigns a newly created cat as @cat" do
        expect(assigns(:cat)).to eq(Cat.last)
      end

      it "redirects to the index view" do
        expect(response).to redirect_to action: :index
      end
    end

    context "when valid parameters are passed" do
      before :each do
        @valid_cat = Cat.create(url: "http://24.media.tumblr.com/tumblr_lkeyplqBY01qf9vi2o1_500.jpg", description: "hola i'm a cat")
        allow(controller).to receive(:require_login)
        put :update, id: @valid_cat.id, :cat => @valid_cat.attributes = { url: "", description: "" }
      end

      it "assigns the original (not updated) cat as @cat" do
        expect(assigns(:cat).url).to eq(@valid_cat.url)
      end

      it "re-renders to the edit view" do
        expect(response).to render_template :edit
      end
    end

  end
end












class Cats::VotesController < ApplicationController

  def index
    @cats = Cat.generate_random
  end

  def create_amazing
    cat = Cat.find_by(id: params[:id])
    cat.votes.create(category: "Amazing! So Beautiful!", IP_Address: request.remote_ip)
    redirect_to cats_votes_path
  end

  def create_cute
    cat = Cat.find_by(id: params[:id])
    cat.votes.create(category: "ZOMG! Cute!", IP_Address: request.remote_ip)
    redirect_to cats_votes_path
  end
end
class Cats::VotesController < ApplicationController

  def index
    @cats = Cat.generate_random

  end


  def create
    cat = Cat.find_by(id: params[:id])
    # p request.env["HTTP_X_FORWARDED_FOR"]

    create_zomg_vote(cat) if params[:category] == "Amazing"
    create_amazing_vote(cat) if params[:category] == "Zomg"

    redirect_to cats_votes_path
  end


  private

  def create_zomg_vote(cat)
    cat.votes.create!(category: "ZOMG! Cute!", IP_Address: request.remote_ip)
  end

  def create_amazing_vote(cat)
    cat.votes.create!(category: "Amazing! So Beautiful!", IP_Address: request.remote_ip)
  end
end
class Cats::VotesController < ApplicationController

  def index
    @cats = Cat.generate_random

  end

  def create
    cat = Cat.find_by(id: params[:id])

    cat.create_vote("Amazing! So Beautiful!", request.remote_ip) if params[:category] == "Amazing"
    cat.create_vote("ZOMG! Cute!", request.remote_ip) if params[:category] == "Zomg"

    redirect_to cats_votes_path
  end

  # private

  # def create_zomg_vote(cat)
  #   cat.votes.create!(category: "ZOMG! Cute!", IP_Address: request.remote_ip)
  # end

  # def create_amazing_vote(cat)
  #   cat.votes.create!(category: "Amazing! So Beautiful!", IP_Address: request.remote_ip)
  # end
end
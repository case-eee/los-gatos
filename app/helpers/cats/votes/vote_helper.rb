module Cats::Votes::VoteHelper
  def zomg_button(cat)
    cats_votes_path(id: cat.id, category: 'Zomg')
  end


  def amazing_button(cat)
    cats_votes_path(id: cat.id, category: 'Amazing')
  end
end
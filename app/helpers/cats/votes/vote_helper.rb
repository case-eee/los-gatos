module Cats::Votes::VoteHelper
  def cute_button(cat)
    cats_create_cute_path(id: cat.id)
  end

  def amazing_button(cat)
    cats_create_amazing_path(id: cat.id)
  end
end
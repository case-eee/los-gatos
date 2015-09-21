class Cat < ActiveRecord::Base
  has_many :votes

  validates_presence_of :url, :description

end


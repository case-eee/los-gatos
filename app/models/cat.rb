class Cat < ActiveRecord::Base
  has_many :votes

  validates_presence_of :url, :description

  def self.generate_random
    all.sample(2)
  end

end


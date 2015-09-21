class Vote < ActiveRecord::Base
  belongs_to :cat

  validates_presence_of :cat, :IP_Address, :category
end

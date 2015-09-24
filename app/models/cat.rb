class Cat < ActiveRecord::Base
  has_many :votes

  validates_presence_of :url, :description

  def self.generate_random
    all.sample(2)
  end

  def amazing_count
    votes.where(category: "Amazing! So Beautiful!").count
  end

  def cute_count
    votes.where(category: "ZOMG! Cute!").count
  end

  def self.sort_by_amazing
    all.sort_by(&:amazing_count).reverse
  end

  def self.sort_by_cute
    all.sort_by(&:cute_count).reverse
  end

  # def sort(category)
  #   all.sort { |x,y| x.category <=> y.category }.reverse
  # end

  def self.as_csv(vote_type)
    CSV.generate do |csv|
      csv << ["Cat Url", "IP Address", "Vote Type", "Cute Count", "Amazing Count"]
      if vote_type == "ZOMG! Cute!"
        all.sort_by_cute.each do |item|
          item.votes.each do |vote|
            if vote.category == vote_type
              csv << [item.url, vote.IP_Address, vote.category, item.cute_count, item.amazing_count]
            end
          end
        end
      elsif vote_type == "Amazing! So Beautiful!"
        all.sort_by_amazing.each do |item|
          item.votes.each do |vote|
            if vote.category == vote_type
              csv << [item.url, vote.IP_Address, vote.category, item.cute_count, item.amazing_count]
            end
          end
        end
      end
    end
  end

  def create_vote(type, ip_address)
    votes.create(category: type, IP_Address: ip_address)
  end
end


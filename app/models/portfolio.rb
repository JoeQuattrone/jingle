class Portfolio < ActiveRecord::Base
  belongs_to :user

  #list of portfolios that allow goal sharing
  def self.shareable_portfolios
    Portfolio.all.map do | portfolio |
      (portfolio if portfolio.share_goal == true && portfolio.user_id != nil)
    end.compact
  end

end

require 'bigdecimal'

class Portfolio < ActiveRecord::Base
  belongs_to :user

  #list of portfolios that allow goal sharing
  def self.shareable_portfolios
    Portfolio.all.map do | portfolio |
      (portfolio if portfolio.share_goal == true && portfolio.user_id != nil)
    end.compact
  end


  def years_until_goal
    self.ideal_completion_age - self.current_age
  end

  def net_monthly_income
    self.gross_monthly_income - self.gross_monthly_exp
  end

  def allocation_towards_portfolio
    answer = (self.monthly_addition_to_portfolio / self.net_monthly_income)*100
    answer.round(2)
  end

  def years_until_goal_achieved
    answer = self.ideal_completion_amount/(self.monthly_addition_to_portfolio * 12)**1+(self.estimated_growth_rate/100)
    answer.round(2)
  end

  def amount_by_goal_age
    one = self.current_savings + self.monthly_addition_to_portfolio * 12.0

    two = one**(1 + self.estimated_growth_rate / 100.0)

    answer= two * self.years_until_goal_achieved
    answer.round(2)
  end



  #Takes in a number and adds commas to string
  def to_comma(number)
    whole, decimal = number.to_s.split(".")
    whole_with_commas = whole.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    [whole_with_commas, decimal].compact.join(".")
  end

end

require 'bigdecimal'

class Portfolio < ActiveRecord::Base
  belongs_to :user
  attr_accessor :projected_amount, :projected_contribution, :projected_time

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

  #incorrect
  def years_until_goal_achieved
    decimal_growth_rate = (self.estimated_growth_rate/100)
    yearly_contribution = self.monthly_addition_to_portfolio * 12
    fv_of_current_savings = self.current_savings * (1 + decimal_growth_rate)**self.years_until_goal

    years = Math.log((1+ ((self.ideal_completion_amount - fv_of_current_savings)*decimal_growth_rate)/yearly_contribution))/Math.log(1 + decimal_growth_rate)

    years.round(2)
  end

  #correct
  def amount_by_goal_age
    decimal_growth_rate = (self.estimated_growth_rate/100)
    yearly_contribution = self.monthly_addition_to_portfolio * 12


    initial_money = self.current_savings * (1 + decimal_growth_rate)**self.years_until_goal

    contributions_future_value = (yearly_contribution * (1 + decimal_growth_rate)**self.years_until_goal - 1)/(decimal_growth_rate)

    answer =  contributions_future_value + initial_money
    answer.round(2)
  end

  def projected_amount_by_goal_end(years_until_amount, amount)
    decimal_growth_rate = (self.estimated_growth_rate/100)
    old_yearly_contribution = self.monthly_addition_to_portfolio * 12
    new_years_until_goal = self.years_until_goal - years_until_amount
    new_yearly_contribution = amount * 12
    initial_money = self.current_savings * (1 + decimal_growth_rate)**self.years_until_goal

    old_contributions_future_value = (old_yearly_contribution *(1 + decimal_growth_rate)**years_until_amount - 1)/(decimal_growth_rate)

     new_contributions_future_value = (new_yearly_contribution * (1 + decimal_growth_rate)**(new_years_until_goal) - 1)/(decimal_growth_rate)

     answer = initial_money + old_contributions_future_value + new_contributions_future_value

     answer.round(2)
  end



  #Takes in a number and adds commas to string
  def to_comma(number)
    whole, decimal = number.to_s.split(".")
    whole_with_commas = whole.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    [whole_with_commas, decimal].compact.join(".")
  end

end

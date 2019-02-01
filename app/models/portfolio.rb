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
    one_plus_growth_rate = (1 + decimal_growth_rate)
    yearly_contribution = self.monthly_addition_to_portfolio * 12

    initial_money = self.current_savings * (1 + decimal_growth_rate)**self.years_until_goal

    contributions_fv_multiplier = ((one_plus_growth_rate**self.years_until_goal) - 1)/decimal_growth_rate

    contributions_fv = yearly_contribution * contributions_fv_multiplier

    answer =  contributions_fv + initial_money
    answer.round(2)
  end

  def projected_amount_by_goal_end(years_until_amount, amount)
    decimal_growth_rate = (self.estimated_growth_rate/100)
    one_plus_growth_rate = (1 + decimal_growth_rate)
    old_yearly_contribution = self.monthly_addition_to_portfolio * 12
    new_years_until_goal = self.years_until_goal - years_until_amount
    new_yearly_contribution = amount * 12
    initial_money = self.current_savings * (1 + decimal_growth_rate)**self.years_until_goal

    #old contribution future value
    old_contributions_fv_multiplier = ((one_plus_growth_rate**years_until_amount) - 1)/decimal_growth_rate

    old_contributions = old_yearly_contribution * old_contributions_fv_multiplier
    #end of old contribution future value

    #new contribution future value
    new_contributions_fv_multiplier = ((one_plus_growth_rate**new_years_until_goal) - 1)/decimal_growth_rate

    new_contributions = new_yearly_contribution * new_contributions_fv_multiplier
    #end of new contribution future value

      #fv of initial money + fv of old contributions +fv of new contributions
     answer = initial_money + old_contributions + new_contributions

     answer.round(2)
  end

  def estimated_contribution_rate
    decimal_growth_rate = (self.estimated_growth_rate/100)
    one_plus_growth_rate = (1 + decimal_growth_rate)
    yearly_contribution = self.monthly_addition_to_portfolio * 12
    initial_money = self.current_savings * (1 + decimal_growth_rate)**self.years_until_goal


    principal = self.ideal_completion_amount - initial_money

    bottom_half = ((one_plus_growth_rate)**self.years_until_goal - 1)/decimal_growth_rate

    answer = (principal/bottom_half)/12

    answer.round(2)

  end



  #Takes in a number and adds commas to string
  def to_comma(number)
    whole, decimal = number.to_s.split(".")
    whole_with_commas = whole.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    [whole_with_commas, decimal].compact.join(".")
  end

end

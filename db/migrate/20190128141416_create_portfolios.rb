class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.integer :user_id
      t.string :portfolio_name
      t.string :portfolio_description
      t.string :goal
      t.integer :current_age
      t.integer :ideal_retirement_age
      t.decimal :ideal_retirement_amount
      t.decimal :gross_monthly_income
      t.decimal :gross_monthly_exp
      t.decimal :monthly_addition_to_portfolio
      t.decimal :estimated_growth_rate
      t.decimal :current_savings
      t.boolean :share_goal
    end
  end
end

class RenamePortfoliosColumns < ActiveRecord::Migration
  def change
    rename_column :portfolios, :ideal_retirement_age, :ideal_completion_age
    rename_column :portfolios, :ideal_retirement_amount, :ideal_completion_amount
  end
end

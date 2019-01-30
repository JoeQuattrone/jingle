User.create(first_name: "Joe", last_name: "Quattrone", email: "test1@test.com", password: "test")
User.create(first_name: "Amanda", last_name: "Smith", email: "amanda@test.com", password: "test")
User.create(first_name: "James", last_name: "Tony", email: "james@test.com", password: "test")
User.create(first_name: "Tony", last_name: "Fergauson", email: "tony@test.com", password: "test")
User.create(first_name: "Dan", last_name: "Rathers", email: "dan@test.com", password: "test")
User.create(first_name: "Andrew", last_name: "Jones", email: "andy@test.com", password: "test")
User.create(first_name: "Lily", last_name: "Apple", email: "lily@test.com", password: "test")

Portfolio.create(user_id: 1, portfolio_name: "Retirement Account", portfolio_description: "Saving for retirement", goal: "Have $1,000,000", current_age: 23, ideal_completion_age: 65, ideal_completion_amount: 1000000.00, gross_monthly_income: 2200, gross_monthly_exp: 1500, monthly_addition_to_portfolio: 300, estimated_growth_rate: 7, current_savings: 15000, share_goal: true)


Portfolio.create(user_id: 2, portfolio_name: "Retirement Account", portfolio_description: "Saving for retirement", goal: "Buy a yacht when I retire", current_age: 32, ideal_completion_age: 68, ideal_completion_amount: 5000000.00, gross_monthly_income: 12200, gross_monthly_exp: 8000, monthly_addition_to_portfolio: 2000, estimated_growth_rate: 7, current_savings: 150000, share_goal: true)

Portfolio.create(user_id: 3, portfolio_name: "Retirement Account", portfolio_description: "Saving for retirement", goal: "Be a baller shotcaller", current_age: 43, ideal_completion_age: 62, ideal_completion_amount: 3000000.00, gross_monthly_income: 10000, gross_monthly_exp: 5000, monthly_addition_to_portfolio: 2200, estimated_growth_rate: 7, current_savings: 1000000, share_goal: true)


Portfolio.create(user_id: 3, portfolio_name: "College Fund", portfolio_description: "Becky's College Fund", goal: "Put Becky through college", current_age: 43, ideal_completion_age: 55, ideal_completion_amount: 120000, gross_monthly_income: 10000, gross_monthly_exp: 5000, monthly_addition_to_portfolio: 400, estimated_growth_rate: 7, current_savings: 20000, share_goal: true)

Portfolio.create(user_id: 4, portfolio_name: "Rainy Day", portfolio_description: "Rainy day or emergency fund", goal: "Have enough money to be comfortable in case of an emergency", current_age: 30, ideal_completion_age: 50, ideal_completion_amount: 80000, gross_monthly_income: 13000, gross_monthly_exp: 7000, monthly_addition_to_portfolio: 800, estimated_growth_rate: 7, current_savings: 10000, share_goal: true)

Portfolio.create(user_id: 5, portfolio_name: "Retirement Account", portfolio_description: "Retirement", goal: "Retire and leave some to my kids", current_age: 28, ideal_completion_age: 68, ideal_completion_amount: 2500000, gross_monthly_income: 10500, gross_monthly_exp: 6800, monthly_addition_to_portfolio: 1800, estimated_growth_rate: 7, current_savings: 100000, share_goal: true)

Portfolio.create(user_id: 6, portfolio_name: "Move Away", portfolio_description: "Savings to move to Europe", goal: "Move to Europe", current_age: 25, ideal_completion_age: 29, ideal_completion_amount: 50000, gross_monthly_income: 5000, gross_monthly_exp: 2500, monthly_addition_to_portfolio: 1000, estimated_growth_rate: 7, current_savings: 5000, share_goal: true)

Portfolio.create(user_id: 7, portfolio_name: "Retirement", portfolio_description: "Retire", goal: "Have enough to get by", current_age: 55, ideal_completion_age: 70, ideal_completion_amount: 80000, gross_monthly_income: 7000, gross_monthly_exp: 4500, monthly_addition_to_portfolio: 1900, estimated_growth_rate: 7, current_savings: 500000, share_goal: true)

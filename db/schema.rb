# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190128141416) do

  create_table "portfolios", force: :cascade do |t|
    t.integer "user_id"
    t.string  "portfolio_name"
    t.string  "portfolio_description"
    t.string  "goal"
    t.integer "current_age"
    t.integer "ideal_retirement_age"
    t.decimal "ideal_retirement_amount"
    t.decimal "gross_monthly_income"
    t.decimal "gross_monthly_exp"
    t.decimal "monthly_addition_to_portfolio"
    t.decimal "estimated_growth_rate"
    t.decimal "current_savings"
    t.boolean "share_goal"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
  end

end

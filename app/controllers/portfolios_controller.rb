class PortfoliosController < ApplicationController

  get "/portfolios" do
    if Helpers.is_logged_in?(session)
      @portfolios = Portfolio.shareable_portfolios
      @all_users = User.all
      @user = User.find(session[:id])
      erb :"portfolio/index"
    else
      redirect to "/login"
    end
  end

end

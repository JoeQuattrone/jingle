class PortfoliosController < ApplicationController
  use Rack::Flash

  get '/portfolios' do
    if Helpers.is_logged_in?(session)
      @portfolios = Portfolio.shareable_portfolios.last(5)
      @all_users = User.all
      @user = User.find(session[:id])
      erb :"portfolio/index"
    else
      redirect to '/login'
    end
  end

  get '/portfolios/new' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :"portfolio/new"
    else
      redirect to '/'
    end
  end

  get "/portfolios/allgoals" do
    if Helpers.is_logged_in?(session)
      @portfolios = Portfolio.shareable_portfolios
      @all_users = User.all
      erb :"portfolio/allgoals"
    end
  end

  post '/portfolios' do
    if params.any? { |key, param| param.nil? || param == '' }
      flash[:notice] = "You must fill out all fields"
      redirect to '/portfolios/new'
    else
      @user = Helpers.current_user(session)
      @portfolio = Portfolio.new(params)
      @portfolio.user_id = @user.id
      @portfolio.save
      redirect to "portfolios/#{@portfolio.id}"
    end
  end

  get '/portfolios/:id' do
    @portfolio = Portfolio.find(params[:id])
    if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == @portfolio.user_id
      erb :"portfolio/show"
    else
      redirect to '/login'
    end
  end

  get '/portfolios/:id/edit' do
    @portfolio = Portfolio.find(params[:id])
    if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == @portfolio.user_id
      erb :"portfolio/edit"
    else
      flash[:notice] = "Permission denied"
      redirect to "/login"
    end
  end

  patch "/portfolios/:id" do
    @portfolio = Portfolio.find(params[:id])
    params.shift
    if params.any? {|key, param| param == "" || param == nil}
      raise "Error you can't delete data"
      redirect to "/portfolios/#{@portfolio.id}/edit"
    else
      @portfolio.update(params)
      redirect to "/portfolios/#{@portfolio.id}"
    end
  end

  delete "/portfolios/:id" do
      @portfolio = Portfolio.find(params[:id])
      if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == @portfolio.user_id
        @portfolio.delete
      end
      redirect to "/portfolios"
    end

    get "/portfolios/:id/predictions" do
      @portfolio = Portfolio.find(params[:id])
      if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == @portfolio.user_id
        erb :"portfolio/prediction"
      end
    end

    post "/portfolios/:id/predictions" do
      @portfolio = Portfolio.find(params[:id])
      @portfolio.projected_contribution = params[:prediction_amount].to_i
      @portfolio.projected_time = params[:years_until_amount].to_i
      @portfolio.projected_amount = @portfolio.projected_amount_by_goal_end(@portfolio.projected_time, @portfolio.projected_contribution)
        erb :"portfolio/prediction_results"
    end

    get "/portfolios/:id/predictionresults" do
      @portfolio = Portfolio.find(params[:id])
      erb :"portfolio/prediction_results"
    end

    post "/portfolios/search" do
      @all_users = User.all
      @search_results = @all_users.find_all do |user|
        user.first_name.downcase.include?(params[:name].downcase)
      end
        @portfolios =  @search_results.map do |user|
          user.portfolios
      end.flatten
      erb :"portfolio/allgoals"
    end



end

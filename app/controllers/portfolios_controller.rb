class PortfoliosController < ApplicationController

  get '/portfolios' do
    if Helpers.is_logged_in?(session)
      @portfolios = Portfolio.shareable_portfolios
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

  post '/portfolios' do
    if params.any? { |param| param.nil? || param == '' }
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
    if Helpers.is_logged_in?(session)
      @portfolio = Portfolio.find(params[:id])
      erb :"portfolio/edit"
    else
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

end

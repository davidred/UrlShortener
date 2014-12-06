class UrlsController < ApplicationController

  def index
    @urls = Url.order(num_visits: :desc).limit(100)
    @url
  end

  def create
    @urls = Url.order(num_visits: :desc).limit(100)
    @url = Url.find_by_long_url(url_params['long_url'])
    if @url
      render :index
    else
      @url = Url.new(url_params)
      short = Url.shorten
      @url.short_url = short
      if @url.save
        render :index
      else
        flash[:errors] = @url.errors.full_messages
        render :index
      end
    end
  end

  def redirect_to
    @url = Url.find_by_short_url(url_params[:short_url])
    if @url
      @url.num_visits += 1
      @url.save
      @urls = Url.order(num_visits: :desc).limit(100)
      render :index
    else
      @urls = Url.order(num_visits: :desc).limit(100)
      flash[:errors] = ["Invalid Short URL"]
      render :index
    end
  end

  def redirect
    @url = Url.find_by_short_url(params[:short_url])
    @urls = Url.order(num_visits: :desc).limit(100)
    render :index
  end

  def destroy
    @url = Url.find(params[:id])
  end

  private

  def url_params
    params.require(:url).permit(:long_url, :short_url)
  end

end

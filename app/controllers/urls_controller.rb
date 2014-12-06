class UrlsController < ApplicationController

  def index
    @urls = Url.all
  end

  def create
    @urls = Url.all
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

  def redirect
    url = params[:short_url]
    redirect_to url
  end

  def destroy
    @url = Url.find(params[:id])
  end

  private

  def url_params
    params.require(:url).permit(:long_url)
  end

end

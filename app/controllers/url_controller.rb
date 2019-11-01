# frozen_string_literal: true

class UrlController < ApplicationController #:nodoc:
  def index; end

  def create
    @url = Url.create!(url_params)
  end

  def redirector
    url = Url.find_by(shorten: params[:shorten])
    raise 'Invalid URL' unless url

    redirect_to url.source
    url.update_analytic(request.location.country, request.ip)
  end

  def stats
    @statistics = Url.stats
  end

  private

  def url_params
    params.require(:url).permit(:source)
  end
end

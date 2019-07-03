class SearchesController < ApplicationController
  def search
  end
  def friends
    resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
      req.params['oauth_token'] = session[:token]
      req.params['v'] = '20160201'
      req.params['v'] = '20160201'
    end
    @friends = JSON.parse(resp.body)["response"]["friends"]["items"]
  end

  def foursquare
    client_id = "3J0DNO5LIJ1PMC4MCDKHNG3A4HTOKMTJ3YPDNFU2F32OUOMK"
    client_secret = "KU0QSQ5ZOXP12EGRNXWGV5MAZZBGI1ZWUEME3PUYC1FHDGC5"

    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "3J0DNO5LIJ1PMC4MCDKHNG3A4HTOKMTJ3YPDNFU2F32OUOMK"
      req.params['client_secret'] = "KU0QSQ5ZOXP12EGRNXWGV5MAZZBGI1ZWUEME3PUYC1FHDGC5"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body = JSON.parse(@resp.body)

    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'
  end
end

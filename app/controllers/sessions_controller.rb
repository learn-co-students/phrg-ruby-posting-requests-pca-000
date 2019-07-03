class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = ENV["3J0DNO5LIJ1PMC4MCDKHNG3A4HTOKMTJ3YPDNFU2F32OUOMK"]
      req.params['client_secret'] = ENV["KU0QSQ5ZOXP12EGRNXWGV5MAZZBGI1ZWUEME3PUYC1FHDGC5"]
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end

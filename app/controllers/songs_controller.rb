class SongsController < ApplicationController

  def search
    tracks = SOUNDCLOUD_API.get('/tracks', limit: 10)
    render json:
  end





end

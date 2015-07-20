class SongsController < ApplicationController

  def create
    @song = Song.new(title: params[:title], artist: params[:artist], properties: params[:properties])
    @song.save
      render json: @song, status: :created
  end

  def index
    @song = Song.all
    render json: { song: @song.as_json(only: :title, :artist, :permalink_url, :artwork_url, :duration, :genre) }
    #include genre?
    render status: :ok
  end

  def show
    @song = song.find(params[:id])
    render status: :ok
  end

  # def something
  #   client = SoundCloud.new(client_id: ENV['SOUNDCLOUD_CLIENT_ID'])
  #   @user = Band.find_by(username: params[:username])
  #   tracks = client.get
  #   # /users/:username/upload
  #
  #   track = client.get
  # end

end

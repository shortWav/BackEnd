SOUNDCLOUD_API = SoundCloud.new({
  :client_id     => ENV['SOUNDCLOUD_CLIENT_ID'],
  :client_secret => ENV['SOUNDCLOUD_SECRET_ID'],
  :redirect_uri  => ENV['REDIRECT_URI']
})

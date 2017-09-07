# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], { scope: 'email,public_profile,user_likes' }
  #provider :facebook, '1885733625009073', '022336ea29f62fb77bbe1bc2e93b4977', { scope: 'email,public_profile,user_likes' }
  #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  #provider :twitter, '1zBu1IhQ6GdPe6192FmNmfpbO', 'lcgFeKuUObhOm1bSsdF3SNkPB9ApQq9i4jVuKhqQhOfOg77Txf'
  #provider :instagram, ENV['INSTAGRAM_KEY'], ENV['INSTAGRAM_SECRET'], scope: 'basic+media+public_content+follower_list+comments+relationships+likes'
end
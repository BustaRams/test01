if Rails.env.production?
  $redis = Redis.new(:url => ENV.fetch("REDISCLOUD_URL"))
end
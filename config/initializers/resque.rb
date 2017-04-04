if Rails.env.production?
  uri = URI.parse ENV.fetch("REDISCLOUD_URL")
  Resque.redis = Redis.new host:uri.host, port:uri.port, password:uri.password
end
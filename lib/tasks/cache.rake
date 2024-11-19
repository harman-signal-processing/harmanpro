namespace :cache do
    
  desc "Clears the redis cache"
  task :flush_redis => :environment do
    redis = Redis.new(url: ENV['REDIS_URL'])
    redis.flushall
  end

end
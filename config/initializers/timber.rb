if Rails.env.production?
  http_device = Timber::LogDevices::HTTP.new(ENV['TIMBER_API_KEY'], ENV['TIMBER_SOURCE_ID'])
  Rails.logger = Timber::Logger.new(http_device)
else
  Rails.logger = Timber::Logger.new(STDOUT)
end

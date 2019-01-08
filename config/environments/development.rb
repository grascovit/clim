Rails.application.configure do
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Install the Timber.io logger
  # ----------------------------
  # Remove the `http_device` to stop sending development logs to Timber.
  # Be sure to keep the `file_device` or replace it with `STDOUT`.
  http_device = Timber::LogDevices::HTTP.new('8301_1c0fd59bc291470c:96985bbb9338e9c9766d928391ef68129331829f8b16d8debc8a5be5567f1311')
  file_device = File.open("#{Rails.root}/log/development.log", "a")
  file_device.binmode
  log_devices = [http_device, file_device]

  # Do not modify below this line. It's important to keep the `Timber::Logger`
  # because it provides an API for logging structured data and capturing context.
  logger = Timber::Logger.new(*log_devices)
  logger.level = config.log_level
  config.logger = ActiveSupport::TaggedLogging.new(logger)
end

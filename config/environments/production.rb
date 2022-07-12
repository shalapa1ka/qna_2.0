# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.compile = false
  config.active_storage.service = :local
  config.log_level = :info
  config.log_tags = [:request_id]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.active_support.disallowed_deprecation = :log
  config.active_support.disallowed_deprecation_warnings = []
  config.log_formatter = ::Logger::Formatter.new

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
  config.require_master_key = true
  config.action_mailer.default_url_options = { host: 'qna-popovych.herokuapp.com', protocol: 'https' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'qna-popovych.herokuapp.com',
    user_name: Rails.application.credentials.google[:mailer_mail],
    password: Rails.application.credentials.google[:mailer_password],
    authentication: 'plain',
    enable_starttls_auto: true,
    open_timeout: 5,
    read_timeout: 5 }
end

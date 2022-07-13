# frozen_string_literal: true

require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.aws.access_key,
    aws_secret_access_key: Rails.application.credentials.aws.secret_key,
    region: 'us-east-1'
  }
  config.fog_directory = Rails.application.credentials.aws.bucket
  config.fog_public = false
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.storage = :fog
end

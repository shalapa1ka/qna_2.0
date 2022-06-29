# frozen_string_literal: true

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [25, 25]
  end

  version :medium do
    process resize_to_fill: [100, 100]
  end

  version :small do
    process resize_to_fill: [50, 50]
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/#{[version_name, 'default-avatar.jpg'].compact.join('_')}")
  end
end

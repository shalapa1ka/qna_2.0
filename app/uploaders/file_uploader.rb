# frozen_string_literal: true

class FileUploader < CarrierWave::Uploader::Base
  storage Rails.env == 'production' ? :fog : :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end

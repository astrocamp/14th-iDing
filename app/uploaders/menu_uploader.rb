# frozen_string_literal: true

class MenuUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fit: [1260, 540]

  version :thumb do
    process resize_to_fit: [200, 200]
  end

  def extension_allowlist
    %w[jpg jpeg gif png avif]
  end
end

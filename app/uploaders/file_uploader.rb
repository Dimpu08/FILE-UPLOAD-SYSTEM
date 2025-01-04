class FileUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :compress_image

  private

  def compress_image
    if file.content_type.start_with?('image/')
      manipulate! do |img|
        img.strip
        img.resize "1200x1200>"
        img.quality "85"
        img
      end
    end
  end
end

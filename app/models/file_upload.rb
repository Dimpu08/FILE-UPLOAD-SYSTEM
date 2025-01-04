class FileUpload < ApplicationRecord
  belongs_to :user

  validates :title, :file, presence: true
  validate :validate_file_size

  mount_uploader :file, FileUploader
  before_create :generate_shared_url

  private

  def validate_file_size
    if file.present? && file.size > 1.gigabytes
      errors.add(:file, "File size must be less than 1GB")
    end
  end

  def generate_shared_url
    self.shared_url = "https://short.url/#{SecureRandom.urlsafe_base64(10)}"
  end
end


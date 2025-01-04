class FileUploadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_file_upload, only: [:destroy, :share]

  def index
    @file_uploads = current_user.file_uploads.order(created_at: :desc)
  end

  def new
    @file_upload = FileUpload.new
  end

  def create
    @file_upload = current_user.file_uploads.build(file_upload_params)

    if @file_upload.save
      redirect_to file_uploads_path, notice: 'File uploaded successfully.'
    else
      render :new, alert: @file_upload.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @file_upload.destroy
      redirect_to file_uploads_path, notice: 'File deleted successfully.'
    else
      redirect_to file_uploads_path, alert: 'Error deleting file.'
    end
  end

  def share
    if @file_upload.shared_url
      redirect_to file_uploads_path, notice: "Shared URL: #{@file_upload.shared_url}"
    else
      redirect_to file_uploads_path, alert: 'Error generating shared URL.'
    end
  end

  private

  def set_file_upload
    @file_upload = current_user.file_uploads.find_by(id: params[:id])
    redirect_to file_uploads_path, alert: 'File not found.' unless @file_upload
  end

  def file_upload_params
    params.require(:file_upload).permit(:title, :description, :file)
  end

  def all_files
    @file_uploads = current_user.file_uploads
  end
end

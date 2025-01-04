class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :excluded_controller?

  private

  def excluded_controller?
    devise_controller? || (request.path == new_user_session_path)
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to new_user_session_path, alert: 'You must sign in or sign up before continuing.'
    end
  end
end

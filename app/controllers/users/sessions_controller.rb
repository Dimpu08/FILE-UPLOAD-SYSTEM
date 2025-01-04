class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)
    if resource.nil?
      flash[:alert] = 'Invalid email or password. Please sign up if you do not have an account.'
      redirect_to new_user_registration_path
    else
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  def new
    super
  end
end

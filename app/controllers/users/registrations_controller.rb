# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    users_profile_path
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

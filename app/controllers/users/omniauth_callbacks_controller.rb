class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  protect_from_forgery except: :saml
  skip_before_action :verify_authenticity_token, only: :saml

  def saml
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user&.persisted?
      @user.remember_me = true
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "SAML") if is_navigational_format?
    else
      session['devise.saml_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_session_url
    end
  end

  def failure
    redirect_to root_path
  end
end
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
#  include SessionsHelper
  before_filter :configure_devise_params, if: :devise_controller?
  before_filter :set_locale

  protected
    def configure_devise_params
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :remember_me, :name) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }

    end

    def set_locale
      locale = params[:locale] || locale_from_accept_language
      I18n.locale = (I18n::available_locales.include? locale.to_sym) ? locale.to_sym : I18n.default_locale
    end
 
    def locale_from_accept_language 
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end


end

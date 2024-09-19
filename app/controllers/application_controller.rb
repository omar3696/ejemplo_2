class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_usuario!, if: :devise_controller?

  def after_sign_out_path_for(resource_or_scope)
    new_usuario_session_path # Redirige al inicio de sesión
  end

  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:rol])
    devise_parameter_sanitizer.permit(:account_update, keys: [:rol])
  end
end

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  #before_action :authenticate_usuario!, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(resource_or_scope)
    new_usuario_session_path # Redirige al inicio de sesión
  end

  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nombre, :apellido, :rol, :alumno_id, :profesor_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nombre, :apellido, :rol, :alumno_id, :profesor_id]) 
  end

  def after_sign_in_path_for(resource)
    case resource.rol
    when 'alumno'
      notas_path # Redirige a las notas del alumno
    when 'profesor'
      materias_path # Redirige a las materias del profesor
    when 'admin'
      colegios_path # O donde quiera que el admin sea redirigido
    else
      root_path # Redirige a la página principal si no tiene rol específico
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_usuario
      if current_usuario.alumno?
        flash[:alert] = "No tienes permiso para acceder a esta sección."
        redirect_to notas_path # Redirige al panel de administración
      elsif current_usuario.profesor?
        flash[:alert] = "No tienes permiso para acceder a esta sección."
        redirect_to materias_path # Redirige al panel de usuario regular
      else
        flash[:alert] = "No tienes permiso para acceder a esta sección."
        redirect_to root_path # Redirige a la página principal por defecto
      end
    else
      flash[:alert] = "Debes iniciar sesión para acceder a esta página."
      redirect_to new_user_session_path
    end
  end

  def authenticate_request
    token = request.headers['Authorization']
    puts token
    begin
    decoded = JWT.decode(token, "123456789", true, { algorithm: 'HS256' })
    decoded = decoded[0]
    @current_usuario = Usuario.find(decoded["usuario_id"])
    rescue JWT::DecodeError
      render json: { error: 'Token no válido' }, status: :unauthorized
    end
  end
end

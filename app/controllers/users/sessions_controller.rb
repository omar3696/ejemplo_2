# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Inicio de sesión exitoso."

      # Redirige según el rol del usuario
      case user.rol
      when 'admin'
        redirect_to admin_dashboard_path
      when 'profesor'
        redirect_to profesor_dashboard_path
      when 'alumno'
        redirect_to alumno_notas_path
      else
        redirect_to root_path
      end
    else
      flash.now[:alert] = "Email o contraseña incorrectos."
      render :new
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end 
end

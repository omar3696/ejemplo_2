class SesionController < ApplicationController
    skip_before_action :verify_authenticity_token 

    def create
        usuario = Usuario.find_by(email: params[:email])

        if usuario&.valid_password?(params[:password]) 
        token = usuario.generate_token 
        render json: { token: token }, status: :created
        else
        render json: { error: 'Credenciales inválidas' }, status: :unauthorized
        end
    end
end

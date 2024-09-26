class Api::AlumnoApiController < ApplicationController
    before_action :authenticate_request

    def nota_carnet
        alumno = Alumno.find_by(carnet: params[:carnet])

        if alumno
            notas = alumno.notas.includes(:materia).map do |nota|
                {
                  materia: nota.materia.nombre,
                  enero: nota.enero,
                  febrero: nota.febrero,
                  marzo: nota.marzo,
                  abril: nota.abril,
                  mayo: nota.mayo,
                  junio: nota.junio,
                  julio: nota.julio,
                  agosto: nota.agosto,
                  septiembre: nota.septiembre,
                  octubre: nota.octubre,
                  noviembre: nota.noviembre,
                  diciembre: nota.diciembre,
                  promedio: nota.promedio
                }
              end
            promedio = alumno.notas.average(:promedio)
            render json: {carnet: alumno.carnet, nombre: alumno.nombre, notas: notas, promedio: promedio}, status: :ok
        else
            render json: { error: 'Alumno no encontrado' }, status: :not_found
        end
    end
end
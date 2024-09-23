# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new # usuario sin iniciar sesión

    case usuario.rol # Aquí usamos el campo 'rol' del usuario
    when 'admin'
      can :manage, :all
    when 'profesor'
      can :read, Nota do |nota|
        nota.materia.profesor_id == usuario.profesor_id
      end
      can :create, Nota
      can :update, Nota do |nota|
        nota.materia.profesor_id == usuario.profesor_id
      end
      can :delete, Nota do |nota|
        nota.materia.profesor_id == usuario.profesor_id
      end
      can :read, Materia, profesor_id: usuario.profesor_id
      cannot :read, Colegio
      cannot :read, Alumno
    when 'alumno'
      can :read, Nota, alumno_id: usuario.alumno_id
      cannot :read, Materia 
      cannot :read, Colegio
      cannot :read, Alumno
      can :read, Profesor
    else
      can :read, :all
    end
  end
end

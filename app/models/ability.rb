# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new # usuario sin iniciar sesión

    case usuario.rol # Aquí usamos el campo 'rol' del usuario
    when 'admin'
      can :manage, :all
    when 'profesor'
      can :read, :all
      can :create, Nota
      can :update, Nota
      can :delete, Nota
    when 'alumno'
      can :read, :all
    else
      can :read, :all
    end
  end
end

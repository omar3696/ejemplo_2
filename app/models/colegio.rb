class Colegio < ApplicationRecord
    validates :nombre, presence: true
    validates :direccion, presence: true

    has_many :alumnos
    has_many :profesores
    has_many :materias
    has_many :notas
end

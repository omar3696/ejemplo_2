class Profesor < ApplicationRecord
  validates :nombre, presence: true
  validates :colegio_id, presence: true

  has_many :materias
  has_many :notas, through: :materias
  has_many :alumnos, through: :notas
  belongs_to :colegio
  has_one :usuario

  def nombre_completo
    "#{nombre}"
  end
end

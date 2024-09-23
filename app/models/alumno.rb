class Alumno < ApplicationRecord
  validates :nombre, presence: true
  validates :colegio_id, presence: true

  has_many :notas
  has_many :materias, through: :notas
  belongs_to :colegio
  has_one :usuario

  def nombre_completo
    "#{nombre}"
  end
end

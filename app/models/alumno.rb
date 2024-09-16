class Alumno < ApplicationRecord
  validates :nombre, presence: true
  validates :colegio_id, presence: true

  has_many :notas
  belongs_to :colegio
end

class Nota < ApplicationRecord
  validates :nota, presence: true
  validates :alumno_id, presence: true
  validates :materia_id, presence: true
  validates :colegio_id, presence: true

  belongs_to :alumno
  belongs_to :materia
  belongs_to :colegio
end

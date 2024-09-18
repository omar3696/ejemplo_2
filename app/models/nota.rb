class Nota < ApplicationRecord
  validates :alumno_id, presence: true
  validates :materia_id, presence: true
  validates :colegio_id, presence: true

  belongs_to :alumno
  belongs_to :materia
  belongs_to :colegio

  before_save :calcular_promedio


  def calcular_promedio
    meses = [enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre]
    meses.compact! # Elimina valores nil
    self.promedio = meses.sum / meses.size.to_f
  end
end

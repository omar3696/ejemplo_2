class Nota < ApplicationRecord
  validates :alumno_id, presence: true
  validates :materia_id, presence: true
  validates :colegio_id, presence: true

  belongs_to :alumno
  belongs_to :materia
  belongs_to :colegio
 # belongs_to :alumno, class_name: 'Usuario', foreign_key: 'alumno_id'

  before_save :calcular_promedio

  scope :aprobados, -> { where('promedio >= ?', 65) }
  scope :reprobados, -> { where('promedio < ?', 65) }


  def calcular_promedio
    meses = [enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre]
    meses.compact! # Elimina valores nil
    self.promedio = meses.sum / meses.size.to_f
  end

  def estado
    promedio >= 65 ? 'Aprobado' : 'Reprobado'
  end



end

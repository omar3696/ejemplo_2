class Profesor < ApplicationRecord
  validates :nombre, presence: true
  validates :colegio_id, presence: true

  has_many :materias
  belongs_to :colegio
end

class Materia < ApplicationRecord
  validates :nombre, presence: true
  validates :profesor_id, presence: true
  validates :colegio_id, presence: true

  has_many :notas
  belongs_to :profesor
  belongs_to :colegio
end

class Usuario < ApplicationRecord

  belongs_to :alumno, optional: true
  belongs_to :profesor, optional: true
  has_many :notas, foreign_key: 'alumno_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :solo_un_rol

  def alumno?
    rol == 'alumno'
  end

  def profesor?
    rol == 'profesor'
  end

  def admin?
    rol == 'admin'
  end

  private

  def solo_un_rol
    if alumno && profesor
      errors.add(:base, 'Un usuario no puede ser tanto alumno como profesor')
    end
  end
end

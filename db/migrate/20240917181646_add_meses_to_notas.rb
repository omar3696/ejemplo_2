class AddMesesToNotas < ActiveRecord::Migration[7.2]
  def change
    add_column :notas, :enero, :float
    add_column :notas, :febrero, :float
    add_column :notas, :marzo, :float
    add_column :notas, :abril, :float
    add_column :notas, :mayo, :float
    add_column :notas, :junio, :float
    add_column :notas, :julio, :float
    add_column :notas, :agosto, :float
    add_column :notas, :septiembre, :float
    add_column :notas, :octubre, :float
    add_column :notas, :noviembre, :float
    add_column :notas, :diciembre, :float
    add_column :notas, :promedio, :float
  end
end

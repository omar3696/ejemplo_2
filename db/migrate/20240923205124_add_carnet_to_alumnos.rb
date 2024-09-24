class AddCarnetToAlumnos < ActiveRecord::Migration[7.2]
  def change
    add_column :alumnos, :carnet, :integer
  end
end

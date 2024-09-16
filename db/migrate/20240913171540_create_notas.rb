class CreateNotas < ActiveRecord::Migration[7.2]
  def change
    create_table :notas do |t|
      t.float :nota
      t.references :alumno, null: false, foreign_key: true
      t.references :materia, null: false, foreign_key: true
      t.references :colegio, null: false, foreign_key: true

      t.timestamps
    end
  end
end

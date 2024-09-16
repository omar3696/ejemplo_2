class CreateMaterias < ActiveRecord::Migration[7.2]
  def change
    create_table :materias do |t|
      t.string :nombre
      t.references :profesor, null: false, foreign_key: true
      t.references :colegio, null: false, foreign_key: true

      t.timestamps
    end
  end
end

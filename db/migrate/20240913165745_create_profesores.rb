class CreateProfesores < ActiveRecord::Migration[7.2]
  def change
    create_table :profesores do |t|
      t.string :nombre
      t.references :colegio, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateColegios < ActiveRecord::Migration[7.2]
  def change
    create_table :colegios do |t|
      t.string :nombre
      t.string :direccion

      t.timestamps
    end
  end
end

class AddIdsToUsuarios < ActiveRecord::Migration[7.2]
  def change
    add_column :usuarios, :alumno_id, :integer
    add_column :usuarios, :profesor_id, :integer
  end
end

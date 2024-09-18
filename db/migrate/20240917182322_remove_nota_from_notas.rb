class RemoveNotaFromNotas < ActiveRecord::Migration[7.2]
  def change
    remove_column :notas, :nota, :float
  end
end

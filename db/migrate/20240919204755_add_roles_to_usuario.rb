class AddRolesToUsuario < ActiveRecord::Migration[7.2]
  def change
    add_column :usuarios, :rol, :string
  end
end

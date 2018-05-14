class CreateUsuarioRoles < ActiveRecord::Migration
  def change
    create_table :usuario_roles do |t|
      t.integer :usuario_id
      t.integer :role_id
      t.integer :warehouse_id

      t.timestamps
    end
  end
end

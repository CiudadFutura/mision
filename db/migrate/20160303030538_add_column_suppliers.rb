class AddColumnSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :razon_social, :text
    add_column :suppliers, :calle, :text
    add_column :suppliers, :ciudad, :text
    add_column :suppliers, :codigo_postal, :text
    add_column :suppliers, :telefono, :text
    add_column :suppliers, :nombre_contacto, :text
    add_column :suppliers, :email, :text
    add_column :suppliers, :web, :text
    add_column :suppliers, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :suppliers, :longitude, :decimal, {:precision=>10, :scale=>6}
    add_column :suppliers, :error_code, :text
    add_column :suppliers, :description, :text
  end
end

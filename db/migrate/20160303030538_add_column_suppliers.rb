class AddColumnSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :razon_social, :text, default: ''
    add_column :suppliers, :calle, :text, default: ''
    add_column :suppliers, :ciudad, :text, default: ''
    add_column :suppliers, :codigo_postal, :text, default: ''
    add_column :suppliers, :telefono, :text, default: ''
    add_column :suppliers, :nombre_contacto, :text, default: ''
    add_column :suppliers, :email, :text, default: ''
    add_column :suppliers, :web, :text, default: ''
    add_column :suppliers, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :suppliers, :longitude, :decimal, {:precision=>10, :scale=>6}
    add_column :suppliers, :error_code, :text, default: ''
    add_column :suppliers, :description, :text, default: ''
  end
end

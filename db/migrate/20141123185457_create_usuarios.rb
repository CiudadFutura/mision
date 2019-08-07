class CreateUsuarios < ActiveRecord::Migration[5.0]
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :apellido
      t.date :fecha_de_nacimiento
      t.string :calle
      t.string :codigo_postal
      t.string :ciudad
      t.string :pais
      t.string :tel1
      t.string :cel1
      t.string :type

      t.timestamps
    end
  end
end

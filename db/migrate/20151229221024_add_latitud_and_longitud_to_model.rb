class AddLatitudAndLongitudToModel < ActiveRecord::Migration
  def change
    add_column :usuarios, :latitude, :float
    add_column :usuarios, :longitude, :float
  end
end

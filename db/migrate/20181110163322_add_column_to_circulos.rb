class AddColumnToCirculos < ActiveRecord::Migration[5.0]
  def change
    add_column :circulos, :special_type, :boolean, default: false, after: :coordinador_id
  end
end

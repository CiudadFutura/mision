class AddColumnToCirculos < ActiveRecord::Migration
  def change
    add_column :circulos, :special_type, :boolean, default: false, after: :coordinador_id
  end
end

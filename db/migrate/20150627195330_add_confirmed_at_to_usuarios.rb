class AddConfirmedAtToUsuarios < ActiveRecord::Migration[5.0]
  def change
    add_column :usuarios, :confirmed_at, :datetime
  end
end

class AddConfirmedAtToUsuarios < ActiveRecord::Migration[4.2]
  def change
    add_column :usuarios, :confirmed_at, :datetime
  end
end

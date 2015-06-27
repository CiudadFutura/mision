class AddConfirmedAtToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :confirmed_at, :datetime
  end
end

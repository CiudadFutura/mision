class AddErrorCodeAddressToUser < ActiveRecord::Migration
  def change
    add_column :usuarios, :error_code, :string
  end
end

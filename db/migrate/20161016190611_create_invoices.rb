class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
			t.integer :pedido_id
			t.integer :number
			t.string :type
			t.datetime :emission_date
			t.integer :warehouse
			t.integer :mai_id
			t.float	:total_discount
			t.float :total
			t.integer	:total_products

			t.timestamps
    end
  end
end

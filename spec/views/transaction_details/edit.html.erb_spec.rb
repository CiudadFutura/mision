require 'rails_helper'

RSpec.describe "transaction_details/edit", :type => :view do
  before(:each) do
    @transaction_detail = assign(:transaction_detail, TransactionDetail.create!(
      :transaction_id => 1,
      :producto_id => 1,
      :price => 1.5,
      :quantity => 1,
      :subtotal => 1.5
    ))
  end

  it "renders the edit transaction_detail form" do
    render

    assert_select "form[action=?][method=?]", transaction_detail_path(@transaction_detail), "post" do

      assert_select "input#transaction_detail_transaction_id[name=?]", "transaction_detail[transaction_id]"

      assert_select "input#transaction_detail_producto_id[name=?]", "transaction_detail[producto_id]"

      assert_select "input#transaction_detail_price[name=?]", "transaction_detail[price]"

      assert_select "input#transaction_detail_quantity[name=?]", "transaction_detail[quantity]"

      assert_select "input#transaction_detail_subtotal[name=?]", "transaction_detail[subtotal]"
    end
  end
end

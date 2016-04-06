require 'rails_helper'

RSpec.describe "transaction_details/index", :type => :view do
  before(:each) do
    assign(:transaction_details, [
      TransactionDetail.create!(
        :transaction_id => 1,
        :producto_id => 2,
        :price => 1.5,
        :quantity => 3,
        :subtotal => 1.5
      ),
      TransactionDetail.create!(
        :transaction_id => 1,
        :producto_id => 2,
        :price => 1.5,
        :quantity => 3,
        :subtotal => 1.5
      )
    ])
  end

  it "renders a list of transaction_details" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end

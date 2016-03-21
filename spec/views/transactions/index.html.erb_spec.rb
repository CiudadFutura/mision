require 'rails_helper'

RSpec.describe "transactions/index", :type => :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        :account_id => 1,
        :pedido_id => 2,
        :transaction_type => 3,
        :amount => 1.5,
        :description => "MyText"
      ),
      Transaction.create!(
        :account_id => 1,
        :pedido_id => 2,
        :transaction_type => 3,
        :amount => 1.5,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of transactions" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

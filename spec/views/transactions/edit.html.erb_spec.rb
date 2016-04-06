require 'rails_helper'

RSpec.describe "transactions/edit", :type => :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      :account_id => 1,
      :pedido_id => 1,
      :transaction_type => 1,
      :amount => 1.5,
      :description => "MyText"
    ))
  end

  it "renders the edit transaction form" do
    render

    assert_select "form[action=?][method=?]", transaction_path(@transaction), "post" do

      assert_select "input#transaction_account_id[name=?]", "transaction[account_id]"

      assert_select "input#transaction_pedido_id[name=?]", "transaction[pedido_id]"

      assert_select "input#transaction_transaction_type[name=?]", "transaction[transaction_type]"

      assert_select "input#transaction_amount[name=?]", "transaction[amount]"

      assert_select "textarea#transaction_description[name=?]", "transaction[description]"
    end
  end
end

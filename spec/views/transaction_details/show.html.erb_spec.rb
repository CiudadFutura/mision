require 'rails_helper'

RSpec.describe "transaction_details/show", :type => :view do
  before(:each) do
    @transaction_detail = assign(:transaction_detail, TransactionDetail.create!(
      :transaction_id => 1,
      :producto_id => 2,
      :price => 1.5,
      :quantity => 3,
      :subtotal => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/1.5/)
  end
end

require 'rails_helper'

RSpec.describe "suppliers/index", :type => :view do
  before(:each) do
    assign(:suppliers, [
      Supplier.create!(
        :name => "Name",
        :address => "Address",
        :nature => :wholesaler
      ),
      Supplier.create!(
        :name => "Name",
        :address => "Address",
        :nature => :wholesaler
      )
    ])
  end

  it "renders a list of suppliers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "wholesaler", :count => 2
  end
end

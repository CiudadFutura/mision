require 'rails_helper'

RSpec.describe "suppliers/show", :type => :view do
  before(:each) do
    @supplier = assign(:supplier, Supplier.create!(
      :name => "Name",
      :address => "Address",
      :nature => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/1/)
  end
end

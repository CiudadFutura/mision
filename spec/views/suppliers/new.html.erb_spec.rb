require 'rails_helper'

RSpec.describe "suppliers/new", :type => :view do
  before(:each) do
    assign(:supplier, Supplier.new(
      :name => "MyString",
      :address => "MyString",
      :nature => 1
    ))
  end

  it "renders new supplier form" do
    render

    assert_select "form[action=?][method=?]", suppliers_path, "post" do

      assert_select "input#supplier_name[name=?]", "supplier[name]"

      assert_select "input#supplier_address[name=?]", "supplier[address]"

      assert_select "input#supplier_nature[name=?]", "supplier[nature]"
    end
  end
end

require 'rails_helper'

RSpec.describe "compras/new", :type => :view do
  before(:each) do
    assign(:compra, Compra.new())
  end

  it "renders new compra form" do
    render

    assert_select "form[action=?][method=?]", compras_path, "post" do
    end
  end
end

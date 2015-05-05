require 'rails_helper'

RSpec.describe "compras/edit", :type => :view do
  before(:each) do
    @compra = assign(:compra, Compra.create!())
  end

  it "renders the edit compra form" do
    render

    assert_select "form[action=?][method=?]", compra_path(@compra), "post" do
    end
  end
end

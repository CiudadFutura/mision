require 'rails_helper'

RSpec.describe "productos/index", :type => :view do
  before(:each) do
    assign(:productos, [
      Producto.create!(
        :precio => 1.5,
        :nombre => "Nombre",
        :descripcion => "MyText",
        :ahorro => 1.5,
        :cantidad_permitida => 1
      ),
      Producto.create!(
        :precio => 1.5,
        :nombre => "Nombre",
        :descripcion => "MyText",
        :ahorro => 1.5,
        :cantidad_permitida => 1
      )
    ])
  end

  it "renders a list of productos" do
    render
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end

require 'rails_helper'

RSpec.describe "productos/new", :type => :view do
  before(:each) do
    assign(:producto, Producto.new(
      :precio => 1.5,
      :nombre => "MyString",
      :descripcion => "MyText",
      :ahorro => 1.5,
      :cantidad_permitida => 1
    ))
  end

  it "renders new producto form" do
    render

    assert_select "form[action=?][method=?]", productos_path, "post" do

      assert_select "input#producto_precio[name=?]", "producto[precio]"

      assert_select "input#producto_nombre[name=?]", "producto[nombre]"

      assert_select "textarea#producto_descripcion[name=?]", "producto[descripcion]"

      assert_select "input#producto_ahorro[name=?]", "producto[ahorro]"

      assert_select "input#producto_cantidad_permitida[name=?]", "producto[cantidad_permitida]"
    end
  end
end

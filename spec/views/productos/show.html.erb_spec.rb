require 'rails_helper'

RSpec.describe "productos/show", :type => :view do
  before(:each) do
    @producto = assign(:producto, Producto.create!(
      :precio => 1.5,
      :nombre => "Nombre",
      :descripcion => "MyText",
      :ahorro => 1.5,
      :cantidad_permitida => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1/)
  end
end

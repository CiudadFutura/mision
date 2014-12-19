require 'rails_helper'

RSpec.describe "categoria/new", :type => :view do
  before(:each) do
    assign(:categoria, categoria.new(
      :nombre => "MyString",
      :descripcion => "MyText"
    ))
  end

  it "renders new categoria form" do
    render

    assert_select "form[action=?][method=?]", categoria_path, "post" do

      assert_select "input#categoria_nombre[name=?]", "categoria[nombre]"

      assert_select "textarea#categoria_descripcion[name=?]", "categoria[descripcion]"
    end
  end
end

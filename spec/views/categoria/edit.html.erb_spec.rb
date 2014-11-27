require 'rails_helper'

RSpec.describe "categoria/edit", :type => :view do
  before(:each) do
    @categoria = assign(:categoria, categoria.create!(
      :nombre => "MyString",
      :descripcion => "MyText"
    ))
  end

  it "renders the edit categoria form" do
    render

    assert_select "form[action=?][method=?]", categoria_path(@categoria), "post" do

      assert_select "input#categoria_nombre[name=?]", "categoria[nombre]"

      assert_select "textarea#categoria_descripcion[name=?]", "categoria[descripcion]"
    end
  end
end

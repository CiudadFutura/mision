require 'rails_helper'

RSpec.describe "usuarios/edit", :type => :view do
  before(:each) do
    @usuario = assign(:usuario, Usuario.create!(
      :nombre => "MyString",
      :apellido => "MyString",
      :email => "MyString",
      :calle => "MyString",
      :codigo_postal => "MyString",
      :ciudad => "MyString",
      :pais => "MyString",
      :tel1 => "MyString",
      :cel1 => "MyString",
      :type => ""
    ))
  end

  it "renders the edit usuario form" do
    render

    assert_select "form[action=?][method=?]", usuario_path(@usuario), "post" do

      assert_select "input#usuario_nombre[name=?]", "usuario[nombre]"

      assert_select "input#usuario_apellido[name=?]", "usuario[apellido]"

      assert_select "input#usuario_email[name=?]", "usuario[email]"

      assert_select "input#usuario_calle[name=?]", "usuario[calle]"

      assert_select "input#usuario_codigo_postal[name=?]", "usuario[codigo_postal]"

      assert_select "input#usuario_ciudad[name=?]", "usuario[ciudad]"

      assert_select "input#usuario_pais[name=?]", "usuario[pais]"

      assert_select "input#usuario_tel1[name=?]", "usuario[tel1]"

      assert_select "input#usuario_cel1[name=?]", "usuario[cel1]"

      assert_select "input#usuario_type[name=?]", "usuario[type]"
    end
  end
end

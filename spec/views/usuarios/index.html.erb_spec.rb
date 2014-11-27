require 'rails_helper'

RSpec.describe "usuarios/index", :type => :view do
  before(:each) do
    assign(:usuarios, [
      Usuario.create!(
        :nombre => "Nombre",
        :apellido => "Apellido",
        :email => "Email",
        :calle => "Calle",
        :codigo_postal => "Codigo Postal",
        :ciudad => "Ciudad",
        :pais => "Pais",
        :tel1 => "Tel1",
        :cel1 => "Cel1",
        :type => "Type"
      ),
      Usuario.create!(
        :nombre => "Nombre",
        :apellido => "Apellido",
        :email => "Email",
        :calle => "Calle",
        :codigo_postal => "Codigo Postal",
        :ciudad => "Ciudad",
        :pais => "Pais",
        :tel1 => "Tel1",
        :cel1 => "Cel1",
        :type => "Type"
      )
    ])
  end

  it "renders a list of usuarios" do
    render
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Apellido".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Calle".to_s, :count => 2
    assert_select "tr>td", :text => "Codigo Postal".to_s, :count => 2
    assert_select "tr>td", :text => "Ciudad".to_s, :count => 2
    assert_select "tr>td", :text => "Pais".to_s, :count => 2
    assert_select "tr>td", :text => "Tel1".to_s, :count => 2
    assert_select "tr>td", :text => "Cel1".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end

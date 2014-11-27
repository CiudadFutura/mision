require 'rails_helper'

RSpec.describe "usuarios/show", :type => :view do
  before(:each) do
    @usuario = assign(:usuario, Usuario.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Apellido/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Calle/)
    expect(rendered).to match(/Codigo Postal/)
    expect(rendered).to match(/Ciudad/)
    expect(rendered).to match(/Pais/)
    expect(rendered).to match(/Tel1/)
    expect(rendered).to match(/Cel1/)
    expect(rendered).to match(/Type/)
  end
end

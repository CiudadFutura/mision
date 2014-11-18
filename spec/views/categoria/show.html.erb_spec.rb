require 'rails_helper'

RSpec.describe "categoria/show", :type => :view do
  before(:each) do
    @categoria = assign(:categoria, categoria.create!(
      :nombre => "Nombre",
      :descripcion => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/MyText/)
  end
end

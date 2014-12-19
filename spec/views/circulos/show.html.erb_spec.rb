require 'rails_helper'

RSpec.describe "circulos/show", :type => :view do
  before(:each) do
    @circulo = assign(:circulo, Circulo.create!(
      :coordinador_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
  end
end

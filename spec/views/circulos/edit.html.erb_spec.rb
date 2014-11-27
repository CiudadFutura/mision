require 'rails_helper'

RSpec.describe "circulos/edit", :type => :view do
  before(:each) do
    @circulo = assign(:circulo, Circulo.create!(
      :coordinador_id => 1
    ))
  end

  it "renders the edit circulo form" do
    render

    assert_select "form[action=?][method=?]", circulo_path(@circulo), "post" do

      assert_select "input#circulo_coordinador_id[name=?]", "circulo[coordinador_id]"
    end
  end
end

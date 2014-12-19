require 'rails_helper'

RSpec.describe "circulos/new", :type => :view do
  before(:each) do
    assign(:circulo, Circulo.new(
      :coordinador_id => 1
    ))
  end

  it "renders new circulo form" do
    render

    assert_select "form[action=?][method=?]", circulos_path, "post" do

      assert_select "input#circulo_coordinador_id[name=?]", "circulo[coordinador_id]"
    end
  end
end

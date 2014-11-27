require 'rails_helper'

RSpec.describe "circulos/index", :type => :view do
  before(:each) do
    assign(:circulos, [
      Circulo.create!(
        :coordinador_id => 1
      ),
      Circulo.create!(
        :coordinador_id => 1
      )
    ])
  end

  it "renders a list of circulos" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end

require 'rails_helper'

RSpec.describe "categoria/index", :type => :view do
  before(:each) do
    assign(:categoria, [
      categoria.create!(
        :nombre => "Nombre",
        :descripcion => "MyText"
      ),
      categoria.create!(
        :nombre => "Nombre",
        :descripcion => "MyText"
      )
    ])
  end

  it "renders a list of categoria" do
    render
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

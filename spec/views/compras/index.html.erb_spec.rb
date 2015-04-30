require 'rails_helper'

RSpec.describe "compras/index", :type => :view do
  before(:each) do
    assign(:compras, [
      Compra.create!(),
      Compra.create!()
    ])
  end

  it "renders a list of compras" do
    render
  end
end

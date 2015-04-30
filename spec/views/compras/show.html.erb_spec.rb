require 'rails_helper'

RSpec.describe "compras/show", :type => :view do
  before(:each) do
    @compra = assign(:compra, Compra.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

require 'rails_helper'

RSpec.describe "deliveries/new", type: :view do
  before(:each) do
    assign(:delivery, Delivery.new())
  end

  it "renders new delivery form" do
    render

    assert_select "form[action=?][method=?]", deliveries_path, "post" do
    end
  end
end

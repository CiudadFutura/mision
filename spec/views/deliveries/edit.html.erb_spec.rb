require 'rails_helper'

RSpec.describe "deliveries/edit", type: :view do
  before(:each) do
    @delivery = assign(:delivery, Delivery.create!())
  end

  it "renders the edit delivery form" do
    render

    assert_select "form[action=?][method=?]", delivery_path(@delivery), "post" do
    end
  end
end

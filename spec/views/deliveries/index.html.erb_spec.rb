require 'rails_helper'

RSpec.describe "deliveries/index", type: :view do
  before(:each) do
    assign(:deliveries, [
      Delivery.create!(),
      Delivery.create!()
    ])
  end

  it "renders a list of deliveries" do
    render
  end
end

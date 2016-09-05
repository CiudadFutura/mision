require 'rails_helper'

RSpec.describe "delivery_statuses/index", type: :view do
  before(:each) do
    assign(:delivery_statuses, [
      DeliveryStatus.create!(),
      DeliveryStatus.create!()
    ])
  end

  it "renders a list of delivery_statuses" do
    render
  end
end

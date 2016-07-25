require 'rails_helper'

RSpec.describe "delivery_statuses/show", type: :view do
  before(:each) do
    @delivery_status = assign(:delivery_status, DeliveryStatus.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

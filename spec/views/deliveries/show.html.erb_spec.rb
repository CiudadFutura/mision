require 'rails_helper'

RSpec.describe "deliveries/show", type: :view do
  before(:each) do
    @delivery = assign(:delivery, Delivery.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

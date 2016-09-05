require 'rails_helper'

RSpec.describe "delivery_statuses/new", type: :view do
  before(:each) do
    assign(:delivery_status, DeliveryStatus.new())
  end

  it "renders new delivery_status form" do
    render

    assert_select "form[action=?][method=?]", delivery_statuses_path, "post" do
    end
  end
end

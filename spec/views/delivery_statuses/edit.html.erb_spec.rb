require 'rails_helper'

RSpec.describe "delivery_statuses/edit", type: :view do
  before(:each) do
    @delivery_status = assign(:delivery_status, DeliveryStatus.create!())
  end

  it "renders the edit delivery_status form" do
    render

    assert_select "form[action=?][method=?]", delivery_status_path(@delivery_status), "post" do
    end
  end
end

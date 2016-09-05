require 'rails_helper'

RSpec.describe "sectors/edit", type: :view do
  before(:each) do
    @sector = assign(:sector, Sector.create!(
      :name => "",
      :description => "MyText"
    ))
  end

  it "renders the edit sector form" do
    render

    assert_select "form[action=?][method=?]", sector_path(@sector), "post" do

      assert_select "input#sector_name[name=?]", "sector[name]"

      assert_select "textarea#sector_description[name=?]", "sector[description]"
    end
  end
end

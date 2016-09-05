require 'rails_helper'

RSpec.describe "sectors/show", type: :view do
  before(:each) do
    @sector = assign(:sector, Sector.create!(
      :name => "",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end

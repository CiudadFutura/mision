require 'rails_helper'

RSpec.describe "reports/index", :type => :view do
  before(:each) do
    assign(:reports, [
      Report.create!(),
      Report.create!()
    ])
  end

  it "renders a list of reports" do
    render
  end
end

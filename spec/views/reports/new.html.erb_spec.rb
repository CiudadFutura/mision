require 'rails_helper'

RSpec.describe "reports/new", :type => :view do
  before(:each) do
    assign(:report, Report.new())
  end

  it "renders new report form" do
    render

    assert_select "form[action=?][method=?]", reports_path, "post" do
    end
  end
end

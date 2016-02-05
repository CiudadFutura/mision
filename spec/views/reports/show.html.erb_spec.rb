require 'rails_helper'

RSpec.describe "reports/show", :type => :view do
  before(:each) do
    @report = assign(:report, Report.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

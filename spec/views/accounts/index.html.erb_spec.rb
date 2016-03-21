require 'rails_helper'

RSpec.describe "accounts/index", :type => :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        :usuario_id => "",
        :status => "",
        :balance => 1.5
      ),
      Account.create!(
        :usuario_id => "",
        :status => "",
        :balance => 1.5
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end

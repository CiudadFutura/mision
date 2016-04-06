require 'rails_helper'

RSpec.describe "accounts/new", :type => :view do
  before(:each) do
    assign(:account, Account.new(
      :usuario_id => "",
      :status => "",
      :balance => 1.5
    ))
  end

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do

      assert_select "input#account_usuario_id[name=?]", "account[usuario_id]"

      assert_select "input#account_status[name=?]", "account[status]"

      assert_select "input#account_balance[name=?]", "account[balance]"
    end
  end
end

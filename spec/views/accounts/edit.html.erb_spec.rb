require 'rails_helper'

RSpec.describe "accounts/edit", :type => :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :usuario_id => "",
      :status => "",
      :balance => 1.5
    ))
  end

  it "renders the edit account form" do
    render

    assert_select "form[action=?][method=?]", account_path(@account), "post" do

      assert_select "input#account_usuario_id[name=?]", "account[usuario_id]"

      assert_select "input#account_status[name=?]", "account[status]"

      assert_select "input#account_balance[name=?]", "account[balance]"
    end
  end
end

require 'rails_helper'

describe "the signin process", :type => :feature do

  it 'is true' do
    visit('/usuarios/sign_up')
    page.has_content?('Consumidor Colaborativo')
  end
end
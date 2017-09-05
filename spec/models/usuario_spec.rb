require 'rails_helper'

RSpec.describe Usuario, :type => :model do
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:type)}
  it { should validate_uniqueness_of(:email)}
end

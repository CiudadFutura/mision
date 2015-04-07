require 'rails_helper'

RSpec.describe Producto, :type => :model do
  it { should belong_to :supplier }
end

require 'spec_helper'

describe Vote do
  it { is_expected.to respond_to(:brother_id) }
  it { is_expected.to respond_to(:tshirt_id) }
  it { is_expected.to respond_to(:score) }
end

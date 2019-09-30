require 'spec_helper'

describe Circus, type: :model do
  before do
    @circus = Circus.new(brother_id: 1, participation: true)
  end

  subject{ @circus }

  it { is_expected.to respond_to(:brother_id) }
  it { is_expected.to respond_to(:participation) }

end

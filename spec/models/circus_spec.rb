require 'spec_helper'

describe Circus do
  before do
    @circus = Circus.new(brother_id: 1, participation: true)
  end

  subject{ @circus }

  it { should respond_to(:brother_id) }
  it { should respond_to(:participation) }

end

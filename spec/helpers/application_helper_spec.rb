require 'spec_helper'

describe ApplicationHelper do
  it { expect(random_myself).to be_a(String) }
end

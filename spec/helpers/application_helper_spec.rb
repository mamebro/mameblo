require 'spec_helper'

describe ApplicationHelper do
  it '一人称を配列で取得できる' do
    expect(myself).to be_a(Array)
  end
end

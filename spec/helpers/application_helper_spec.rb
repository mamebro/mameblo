require 'spec_helper'

describe ApplicationHelper do
  it '一人称を配列で取得できる' do
    expect(myself).to be_a(Array)
  end

  it '結婚式を配列で取得できる' do
    expect(wedding_party).to be_a(Array)
  end

  it 'カウントダウンの日付を取得できる' do
    expect(countdown(Date.tomorrow.strftime('%Y'), Date.tomorrow.strftime('%m'), Date.tomorrow.strftime('%d'))).to have_content '1'
  end
end

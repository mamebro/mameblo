require 'spec_helper'

describe ApplicationHelper do
  it '一人称を配列で取得できる' do
    expect(myself).to be_a(Array)
  end

  it '結婚式を配列で取得できる' do
    expect(wedding_party).to be_a(Array)
  end

  it 'カウントダウンの日付を取得できる' do
    expect(countdown(Date.tomorrow)).to eq 1
  end

  context 'スタンプの記述がされている時' do
    it 'スタンプへのパスに変換されること' do
      expect(convert_bro(':bro_cheers:')).to eq '<img alt="Cheers" src="/images/stamps/cheers.svg" />'
    end

    it '複数存在する時も変換されること' do
content =<<'EOS'
hi this is test!

:bro_cheers:

:bro_ok:
EOS

converted_content =<<'EOS'
hi this is test!

<img alt="Cheers" src="/images/stamps/cheers.svg" />

<img alt="Ok" src="/images/stamps/ok.svg" />
EOS
      expect(convert_bro(content)).to eq converted_content
    end
  end
end

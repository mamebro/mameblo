require 'spec_helper'

describe ApplicationHelper, type: :helper do
  it '一人称を配列で取得できる' do
    expect(myself).to be_a(Array)
  end

  it 'まめぶろ広告を配列で取得できる' do
    expect(ad).to be_a(Array)
  end

  it 'カウントダウンの日付を取得できる' do
    expect(countdown(Date.tomorrow)).to eq 1
  end

  it 'ブラザー名のイニシャルを取得できる' do
    expect(initial('kurotaky')).to eq 'K.'
  end

  context 'スタンプの記述がされている時' do
    it 'スタンプへのパスに変換されること' do
      expect(convert_bro(':brocheers:')).to match %r{src="/images/stamps/cheers.svg"}
    end

    it '複数存在する時も変換されること' do
content =<<'EOS'
hi this is test!

:brocheers:

:brook:
EOS

converted_content =<<'EOS'
hi this is test!

<img alt="Cheers" class="stamp" src="/images/stamps/cheers.svg" />

<img alt="Ok" class="stamp" src="/images/stamps/ok.svg" />
EOS
      expect(convert_bro(content)).to match %r{hi this is test!}
      expect(convert_bro(content)).to match %r{src="/images/stamps/cheers.svg"}
      expect(convert_bro(content)).to match %r{src="/images/stamps/ok.svg"}
    end
  end
end

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

  context 'ハッシュタグの変換' do
    it 'ハッシュタグがリンクに変換されること' do
      expect(convert_bro('#テスト')).to include('href="/hashtag/テスト"')
    end

    it 'HTMLエンティティの数字部分がハッシュタグと誤認識されないこと' do
      expect(convert_bro('&#39;')).to eq '&#39;'
      expect(convert_bro('&#39;')).not_to include('href="/hashtag/')
    end

    it '全角ハッシュタグも変換されること' do
      expect(convert_bro('＃日本語')).to include('href="/hashtag/日本語"')
    end
  end

  context 'sanitize_markdown' do
    it 'Markdownで生成されるHTMLタグが許可されること' do
      html = '<h1>見出し1</h1><h2>見出し2</h2><p>段落</p>'
      expect(sanitize_markdown(html)).to eq html
    end

    it 'リストタグが許可されること' do
      result = sanitize_markdown('<ul><li>項目1</li><li>項目2</li></ul>')
      expect(result).to include('<ul>')
      expect(result).to include('<li>項目1</li>')
      expect(result).to include('<li>項目2</li>')
      expect(result).to include('</ul>')
    end

    it '番号付きリストタグが許可されること' do
      result = sanitize_markdown('<ol><li>項目1</li><li>項目2</li></ol>')
      expect(result).to include('<ol>')
      expect(result).to include('<li>項目1</li>')
      expect(result).to include('<li>項目2</li>')
      expect(result).to include('</ol>')
    end

    it '強調タグが許可されること' do
      html = '<strong>太字</strong><em>斜体</em>'
      expect(sanitize_markdown(html)).to eq html
    end

    it 'コードタグが許可されること' do
      html = '<pre><code>コード</code></pre>'
      expect(sanitize_markdown(html)).to eq html
    end

    it 'テーブルタグが許可されること' do
      result = sanitize_markdown('<table><thead><tr><th>ヘッダー</th></tr></thead><tbody><tr><td>データ</td></tr></tbody></table>')
      expect(result).to include('<table>')
      expect(result).to include('<thead>')
      expect(result).to include('<th>ヘッダー</th>')
      expect(result).to include('<td>データ</td>')
      expect(result).to include('</table>')
    end

    it 'リンクのhref属性が許可されること' do
      html = '<a href="https://example.com">リンク</a>'
      expect(sanitize_markdown(html)).to eq html
    end

    it '画像のsrc属性とclass属性が許可されること' do
      html = '<img src="/images/test.png" alt="テスト" class="stamp">'
      result = sanitize_markdown(html)
      expect(result).to include('src="/images/test.png"')
      expect(result).to include('alt="テスト"')
      expect(result).to include('class="stamp"')
    end

    it '危険なscriptタグが除去されること' do
      html = '<script>alert("xss")</script><p>安全</p>'
      expect(sanitize_markdown(html)).to eq 'alert("xss")<p>安全</p>'
    end

    it '許可されていない属性が除去されること' do
      html = '<a href="https://example.com" onclick="alert(1)">リンク</a>'
      expect(sanitize_markdown(html)).to eq '<a href="https://example.com">リンク</a>'
    end

    context 'XSSセキュリティ' do
      it 'onclickイベントハンドラが除去されること' do
        html = '<a href="#" onclick="alert(1)">click</a>'
        expect(sanitize_markdown(html)).to eq '<a href="#">click</a>'
      end

      it 'onerrorイベントハンドラが除去されること' do
        html = '<img src="x" onerror="alert(1)">'
        expect(sanitize_markdown(html)).not_to include('onerror')
      end

      it 'javascript: URLが除去されること' do
        html = '<a href="javascript:alert(1)">click</a>'
        expect(sanitize_markdown(html)).not_to include('javascript')
        expect(sanitize_markdown(html)).not_to include('href')
      end

      it 'data: URLが除去されること' do
        html = '<a href="data:text/html,<script>alert(1)</script>">click</a>'
        expect(sanitize_markdown(html)).not_to include('data:')
        expect(sanitize_markdown(html)).not_to include('href')
      end

      it 'iframeタグが除去されること' do
        html = '<iframe src="https://evil.com"></iframe><p>safe</p>'
        expect(sanitize_markdown(html)).not_to include('iframe')
        expect(sanitize_markdown(html)).to include('<p>safe</p>')
      end

      it 'svgタグが除去されること' do
        html = '<svg onload="alert(1)"></svg><p>safe</p>'
        expect(sanitize_markdown(html)).not_to include('svg')
      end

      it 'objectタグが除去されること' do
        html = '<object data="https://evil.com"></object>'
        expect(sanitize_markdown(html)).not_to include('object')
      end

      it 'formタグが除去されること' do
        html = '<form action="https://evil.com"><input type="submit"></form>'
        expect(sanitize_markdown(html)).not_to include('form')
      end

      it 'style属性の危険な値が除去されること' do
        html = '<p style="background:url(javascript:alert(1))">text</p>'
        result = sanitize_markdown(html)
        expect(result).not_to include('javascript')
        expect(result).to include('<p')
      end

      it 'style属性のexpression()が除去されること' do
        html = '<p style="expression(alert(1))">text</p>'
        result = sanitize_markdown(html)
        expect(result).not_to include('expression')
      end

      it 'img要素のjavascript: srcが除去されること' do
        html = '<img src="javascript:alert(1)">'
        expect(sanitize_markdown(html)).not_to include('javascript')
        expect(sanitize_markdown(html)).not_to include('src')
      end
    end
  end
end

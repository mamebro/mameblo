# -*- coding: utf-8 -*-
module ApplicationHelper

  # http://d.hatena.ne.jp/nedate/20101005/1286243852
  module ActionView
    class OutputBuffer < ActiveSupport::SafeBuffer
      def <<(value)
        super(value.to_s.force_encoding('UTF-8'))
      end
      alias :append= :<<
    end
  end

  #Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "まめぶろ"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # HTMLで書けない文字の実体参照と改行コードのHTMLへの置換を行う
  def hbr(target)
    target = html_escape(target)
    target.gsub(/\r\n|\r|\n/, "<br />")
  end
end

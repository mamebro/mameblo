xml.instruct! :xml, :version => "1.0"
xml.rss(
  "version" => "2.0",
  "xmlns:content" => "http://purl.org/rss/1.0/modules/content/",
  "xmlns:wfw" => "http://wellformedweb.org/CommentAPI/",
  "xmlns:dc" => "http://purl.org/dc/elements/1.1/",
  "xmlns:atom" => "http://www.w3.org/2005/Atom",
  "xmlns:sy" => "http://purl.org/rss/1.0/modules/syndication/",
  "xmlns:slash" => "http://purl.org/rss/1.0/modules/slash/"
) do
  xml.channel do
    xml.title "まめぶろ"
    xml.description "かわいいブログ。まめぶろ。"
    xml.link "https://mameblo.com"
    xml.language "ja-ja"
    xml.ttl "40"
    xml.pubDate(Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z"))
    xml.atom :link, "href" => "https://mameblo.com/#{@brother.name}/feed", "rel" => "self", "type" => "application/rss+xml"
    @entries.each do |entry|
      xml.item do
        xml.title entry.title
        xml.description do
          xml.cdata! strip_tags(entry.content)[0..110]
        end
        xml.pubDate entry.created_at
        xml.guid "https://mameblo.com/entries/#{entry.id}"
        xml.link "https://mameblo.com/entries/#{entry.id}"
      end
    end
  end
end

module Ikachan
  def ikachan_join
    config = YAML.load_file(Rails.root.to_s + '/config/irc.yml')
    Net::HTTP.post_form(URI.parse(config['host'] + '/join'), {
      'channel' => '#mameblo',
    })
  end

  def ikachan_post(message)
    config = YAML.load_file(Rails.root.to_s + '/config/irc.yml')
    Net::HTTP.post_form(URI.parse(config['host'] + '/privmsg'), {
      'channel' => '#mameblo',
      'message' => message,
    })
  end
end

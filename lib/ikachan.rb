module Ikachan
  def ikachan_join
    begin
      config = YAML.load_file(Rails.root.to_s + '/config/irc.yml')
      Net::HTTP.post_form(URI.parse(config['host'] + '/join'), {
        'channel' => '#mameblo',
      })
    rescue
      # TODO: send alert mail
    end
  end

  def ikachan_post(message)
    begin
      config = YAML.load_file(Rails.root.to_s + '/config/irc.yml')
      Net::HTTP.post_form(URI.parse(config['host'] + '/privmsg'), {
        'channel' => '#mameblo',
        'message' => message,
      })
    rescue
      # TODO: send alert mail
    end
  end
end

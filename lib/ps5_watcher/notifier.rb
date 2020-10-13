module Ps5Watcher
  class Notifier
    USER_KEY = ENV['PUSHOVER_USER_KEY']
    APP_TOKEN = ENV['PUSHOVER_APP_TOKEN']
    SEND_MESSAGE_ENDPOINT = 'https://api.pushover.net/1/messages.json'.freeze

    def initialize
      @api_url = URI.parse(SEND_MESSAGE_ENDPOINT)

      @connection = Net::HTTP.new(api_url.host, api_url.port)
      connection.use_ssl = true
      connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    def notify(msg, action_url)
      puts msg

      req = Net::HTTP::Post.new(api_url.path)
      req.set_form_data(
        token: APP_TOKEN,
        user: USER_KEY,
        message: msg,
        url: action_url,
        url_title: 'View'
      )

      connection.start { |http| http.request(req) }
    end

    private

    attr_reader :connection, :api_url
  end
end

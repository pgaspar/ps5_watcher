module Ps5Watcher
  class StoreScraper
    attr_reader :url, :selector

    def initialize(url:, selector:)
      @url = url
      @selector = selector
    end

    def can_find_text?(text)
      selected_node = html.css(selector).first
      selected_node && selected_node.text.include?(text)
    end

    private

    def html
      Nokogiri::HTML open(url)
    end
  end
end

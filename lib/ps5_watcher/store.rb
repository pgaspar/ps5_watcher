require 'ostruct'

module Ps5Watcher
  class Store < OpenStruct
    def main_url
      URI(product_url).hostname
    end

    def sold_out?
      scraper.can_find_text?(unavailable_text)
    end

    def in_stock?
      !sold_out?
    end

    private

    def scraper
      @_scraper ||= Ps5Watcher::StoreScraper.new(
        url: product_url,
        selector: selector
      )
    end
  end
end

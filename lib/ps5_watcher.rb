require 'rubygems'

require 'dotenv/load'
require 'net/http'
require 'open-uri'
require 'nokogiri'

require 'ps5_watcher/watcher'
require 'ps5_watcher/store_scraper'
require 'ps5_watcher/store'
require 'ps5_watcher/store_repo'
require 'ps5_watcher/notifier'

module Ps5Watcher
  def self.watch(interval)
    Watcher.new(interval).watch
  end
end

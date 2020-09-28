module Ps5Watcher
  class Watcher
    attr_accessor :notifier, :stores

    def initialize(store_ids: [], interval: 300, store_repo: Ps5Watcher::StoreRepo.new, notifier: Ps5Watcher::Notifier.new)
      @stores = store_repo.stores
      if store_ids.any?
        @stores = @stores.select { |store| store_ids.include?(store.id) }
        raise "No Stores found for IDs: #{store_ids}" if @stores.empty?
      end

      @notifier = notifier
      @interval = interval || 300 # seconds
    end

    def watch
      loop do
        begin
          stores.each do |store|
            notifier.notify("Hey! PS5 is available at #{store.main_url}", store.listing_url) if store.in_stock?
          end
          putc '.'
        rescue OpenURI::HTTPError, SocketError
          puts 'No internet. Waiting...'
          sleep 5
          next
        end

        sleep interval
      end
    end

    private

    attr_reader :interval
  end
end

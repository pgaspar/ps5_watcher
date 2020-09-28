require 'yaml'

module Ps5Watcher
  class StoreRepo
    STORE_CONFIG_PATH = "#{File.dirname(__FILE__)}/../../stores.yml".freeze

    def initialize(config_path = STORE_CONFIG_PATH)
      @store_configs = YAML.load_file(config_path)
    end

    def stores
      store_configs.map do |store_data|
        Ps5Watcher::Store.new(store_data)
      end
    end

    private

    attr_reader :store_configs
  end
end

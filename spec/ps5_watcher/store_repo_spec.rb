RSpec.describe Ps5Watcher::StoreRepo do
  subject(:repo) { described_class.new(STORES_CONFIG_PATH) }

  describe '#stores' do
    it 'successfully loads the store configuration fixtures' do
      stores = repo.stores

      expect(stores.size).to eq 2
      expect(stores.map(&:id)).to match_array(%w[amazon target])

      expect(stores).to all(be_a(Ps5Watcher::Store))

      amazon = stores.find { |store| store.id == 'amazon' }
      expect(amazon.product_url).to eq 'https://amazon.com/product-page'
      expect(amazon.selector).to eq '.aSelector'
      expect(amazon.unavailable_text).to eq 'Unavailable'
    end
  end
end

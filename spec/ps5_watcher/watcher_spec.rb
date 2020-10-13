RSpec.describe Ps5Watcher::Watcher do
  subject(:watcher) { described_class.new(store_repo: repo, store_ids: store_ids) }

  let(:repo) { Ps5Watcher::StoreRepo.new(STORES_CONFIG_PATH) }
  let(:store_ids) { [] }

  describe 'initialization' do
    context 'when no store_ids are passed' do
      let(:store_ids) { [] }

      it 'returns all stores' do
        expect(watcher.stores).to match_array(repo.stores)
      end
    end

    context 'when existing store_ids are passed' do
      let(:store_ids) { ['amazon'] }

      it 'filters stores based on the store_ids parameter' do
        expect(watcher.stores.size).to eq 1
        expect(watcher.stores.first.id).to eq 'amazon'
      end
    end

    context 'when no stores are configured for the given store_ids' do
      let(:store_ids) { ['foobar'] }

      it 'raises an error ' do
        expect { watcher }.to raise_error(StandardError)
      end
    end
  end
end

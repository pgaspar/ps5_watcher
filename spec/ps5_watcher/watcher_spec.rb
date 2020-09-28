RSpec.describe Ps5Watcher::Watcher do
  let(:repo) { Ps5Watcher::StoreRepo.new(STORES_CONFIG_PATH) }
  let(:store_ids) { [] }
  subject { Ps5Watcher::Watcher.new(store_repo: repo, store_ids: store_ids) }

  describe 'initialization' do
    context 'when no store_ids are passed' do
      let(:store_ids) { [] }

      it 'returns all stores' do
        expect(subject.stores).to match_array(repo.stores)
      end
    end

    context 'when existing store_ids are passed' do
      let(:store_ids) { ['amazon'] }

      it 'filters stores based on the store_ids parameter' do
        expect(subject.stores.size).to eq 1
        expect(subject.stores.first.id).to eq 'amazon'
      end
    end

    context 'when no stores are configured for the given store_ids' do
      let(:store_ids) { ['foobar'] }

      it 'raises an error ' do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end

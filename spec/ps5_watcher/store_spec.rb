RSpec.describe Ps5Watcher::Store do
  subject(:store) { described_class.new(store_data) }

  let(:store_data) do
    {
      id: 'the-store',
      product_url: 'https://amazon.com/product-page',
      selector: '.aSelector',
      unavailable_text: 'Not Available'
    }
  end

  it 'exposes data as instance methods' do
    expect(store.id).to eq 'the-store'
    expect(store.selector).to eq '.aSelector'
    expect(store.unavailable_text).to eq 'Not Available'
    expect(store.product_url).to eq 'https://amazon.com/product-page'
    expect(store.main_url).to eq 'amazon.com'
  end

  describe 'stock-related methods' do
    before(:each) do
      allow(store).to receive(:scraper).and_return(scraper_double)
    end

    context 'when the scraper finds the unavailable_text' do
      let(:scraper_double) { instance_double(Ps5Watcher::StoreScraper, can_find_text?: true) }

      it { is_expected.to be_sold_out }
      it { is_expected.not_to be_in_stock }
    end

    context "when the scraper can't find the unavailable_text" do
      let(:scraper_double) { instance_double(Ps5Watcher::StoreScraper, can_find_text?: false) }

      it { is_expected.not_to be_sold_out }
      it { is_expected.to be_in_stock }
    end
  end
end

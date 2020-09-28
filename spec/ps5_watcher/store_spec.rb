RSpec.describe Ps5Watcher::Store do
  let(:store_data) do
    {
      id: 'the-store',
      product_url: 'https://amazon.com/product-page',
      selector: '.aSelector',
      unavailable_text: 'Not Available'
    }
  end
  subject { Ps5Watcher::Store.new(store_data) }

  it 'exposes data as instance methods' do
    expect(subject.id).to eq 'the-store'
    expect(subject.selector).to eq '.aSelector'
    expect(subject.unavailable_text).to eq 'Not Available'
    expect(subject.product_url).to eq 'https://amazon.com/product-page'
    expect(subject.main_url).to eq 'amazon.com'
  end

  describe 'stock-related methods' do
    before(:each) do
      allow(subject).to receive(:scraper).and_return(scraper_double)
    end

    context 'if the scraper finds the unavailable_text' do
      let(:scraper_double) { double(:can_find_text? => true) }

      it { is_expected.to be_sold_out }
      it { is_expected.not_to be_in_stock }
    end

    context "if the scraper can't find the unavailable_text" do
      let(:scraper_double) { double(:can_find_text? => false) }

      it { is_expected.not_to be_sold_out }
      it { is_expected.to be_in_stock }
    end
  end
end

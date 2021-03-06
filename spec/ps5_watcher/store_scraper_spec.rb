RSpec.describe Ps5Watcher::StoreScraper do
  subject(:scraper) do
    described_class.new(
      url: 'http://example.com',
      selector: '.buyStatusSelector'
    )
  end

  before(:each) do
    allow(scraper).to receive(:html).and_return(Nokogiri::HTML(mock_html))
  end

  describe '#can_find_text?' do
    context "when the node couldn't be found" do
      let(:mock_html) { '<div>Status: Unavailable</div>' }

      it 'returns false' do
        expect(scraper.can_find_text?('Unavailable')).to be_falsey
      end
    end

    context 'when the node can be found' do
      let(:mock_html) { '<div class="buyStatusSelector">Status: Unavailable</div>' }

      it 'looks for the passed in text inside the node' do
        expect(scraper.can_find_text?('Unavailable')).to be_truthy
        expect(scraper.can_find_text?('Available')).to be_falsey
      end
    end
  end
end

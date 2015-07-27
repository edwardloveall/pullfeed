require 'rails_helper'

describe 'Empty feed requests' do
  before(:each) do
    allow(Mixpanel::Tracker).to receive(:new).and_return(spy)
  end

  describe 'GET /feeds/:owner/:repo' do
    context 'when a repo has no pull requests' do
      it 'returns an atom response' do
        stub_github_requests
        get feed_path(owner: 'github', repo: 'code')

        expect(response.content_type).to eq(Mime::Type.lookup_by_extension(:atom))
      end

      it 'has feed attributes' do
        stub_github_requests

        get feed_path(owner: 'github', repo: 'code')

        expect(xml[:title]).to eq('github/code pull requests')
        expect(xml[:subtitle]).to eq('A repo with some really good code.')
        expect(xml[:updated]).to eq('2011-05-09T22:53:13+00:00')
        expect(xml[:link]).to eq(feed_link)
        expect(xml[:author][:name]).to eq('github')
      end
    end
  end

  def xml
    @_xml ||= Hash.from_xml(response.body)['feed'].deep_symbolize_keys
  end

  def stub_github_requests
    stub_request(:get, 'https://api.github.com/repos/github/code/pulls').
      to_return(body: fixture_load('github', 'pulls_empty.json'),
                headers: { 'Content-Type' => 'application/json' })
    stub_request(:get, 'https://api.github.com/repos/github/code').
      to_return(body: fixture_load('github', 'repository.json'),
                headers: { 'Content-Type' => 'application/json' })
  end

  def feed_link
    [{ rel: 'alternate', type: 'text/html', href: 'http://www.example.com' },
     { rel: 'self',
       type: 'application/atom+xml',
       href: 'http://www.example.com/feeds/github/code' }]
  end
end

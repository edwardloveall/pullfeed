require 'rails_helper'

describe 'Feed requests' do
  before(:each) do
    allow(KeenAnalytics).to receive(:requested_feed).and_return(spy)
    allow(MixpanelAnalytics).to receive(:requested_feed).and_return(spy)
  end

  describe 'GET /feeds/:owner/:repo' do
    it 'returns an atom response' do
      stub_github_request
      get feed_path(owner: 'github', repo: 'code')

      expect(response.content_type).to eq(Mime::Type.lookup_by_extension(:atom))
    end

    it 'has feed attributes' do
      stub_github_request

      get feed_path(owner: 'github', repo: 'code')

      expect(xml[:title]).to eq('github/code pull requests')
      expect(xml[:subtitle]).to eq('A repo with some really good code.')
      expect(xml[:updated]).to eq('2015-05-05T07:50:40+00:00')
      expect(xml[:link]).to eq(feed_link)
      expect(xml[:author][:name]).to eq('github')
    end

    it 'has entry attributes' do
      stub_github_request

      get feed_path(owner: 'github', repo: 'code')

      expect(first_entry[:title]).to eq('Improve the code very much')
      expect(first_entry[:content]).to eq(html_content)
      expect(first_entry[:link]).to eq(
        href: 'https://github.com/github/code/pull/564',
        rel: 'alternate'
      )
      expect(first_entry[:published]).to eq('2015-05-05T07:50:40+00:00')
      expect(first_entry[:updated]).to eq('2015-05-05T07:50:40+00:00')
      expect(first_entry[:id]).
        to eq('tag:pullfeed.co,2015-05-05:/github/code/pull/564')
      expect(first_entry[:author][:name]).to eq('john-doe')
    end

    it 'formats the dates according to the ISO8601 standard' do
      stub_github_request

      get feed_path(owner: 'github', repo: 'code')
      expect(xml[:updated]).to eq('2015-05-05T07:50:40+00:00')
      expect(first_entry[:published]).to eq('2015-05-05T07:50:40+00:00')
    end
  end

  def xml
    @_xml ||= Hash.from_xml(response.body)['feed'].deep_symbolize_keys
  end

  def first_entry
    @_first_entry = xml[:entry].first
  end

  def stub_github_request
    stub_request(:get, /.*api.github.com.*/).
      to_return(body: fixture_load('github', 'pulls.json'),
                headers: { 'Content-Type' => 'application/json' })
  end

  def html_content
    "<p>A very important pull request that makes the <code>code</code> much better.</p>\n"
  end

  def feed_link
    [{ rel: 'alternate', type: 'text/html', href: 'http://www.example.com' },
     { rel: 'self',
       type: 'application/atom+xml',
       href: 'http://www.example.com/feeds/github/code' }]
  end
end

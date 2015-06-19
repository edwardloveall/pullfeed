require 'rails_helper'

describe 'Repo requests' do
  describe 'GET /feeds/:owner/:repo' do
    it 'returns an rss response' do
      stub_github_request

      get feed_path(owner: 'foo', repo: 'bar')

      expect(response.content_type).to eq(Mime::Type.lookup_by_extension(:rss))
    end

    it 'has channel attributes' do
      stub_github_request

      get feed_path(owner: 'github', repo: 'code')

      expect(xml[:title]).to eq('code pull requests')
      expect(xml[:description]).to eq('A repo with some really good code.')
      expect(xml[:pubDate]).to eq('2015-05-05T07:50:40+00:00')
      expect(xml[:link]).to eq('https://github.com/github/code')
    end

    it 'has item attributes' do
      stub_github_request

      get feed_path(owner: 'github', repo: 'code')

      expect(first_item[:title]).to eq('Improve the code very much')
      expect(first_item[:description]).to eq('A very important pull request that makes the code much better.')
      expect(first_item[:link]).to eq('https://github.com/github/code/pull/564')
      expect(first_item[:pubDate]).to eq('2015-05-05T07:50:40+00:00')
    end
  end

  def xml
    @_xml ||= Hash.from_xml(response.body)['rss']['channel'].deep_symbolize_keys
  end

  def first_item
    @_first_item = xml[:item].first
  end

  def stub_github_request
    stub_request(:get, /.*api.github.com.*/).
      to_return(body: fixture_load('github', 'pulls.json'),
                headers: { "Content-Type" => 'application/json' })
  end
end

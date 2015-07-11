require 'rails_helper'

describe 'Repository not found requests' do
  describe 'GET non-existant repository' do
    it 'renders a 404' do
      stub_github_request

      get feed_path(owner: 'foo', repo: 'bar')

      expect(response).to have_http_status(:not_found)
    end

    it 'returns a content type of html' do
      stub_github_request

      get feed_path(owner: 'foo', repo: 'bar')

      expect(response.content_type).to eq(Mime::Type.lookup_by_extension(:html))
    end
  end

  def stub_github_request
    stub_request(:get, bad_url).
      to_return(body: fixture_load('github', '404.json'),
                headers: { 'Content-Type' => 'application/json' },
                status: 404)
  end

  def bad_url
    'https://api.github.com/repos/foo/bar/pulls'
  end
end

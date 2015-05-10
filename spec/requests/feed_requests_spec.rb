require 'rails_helper'

describe 'Repo requests' do
  describe 'GET /feeds/:owner/:repo' do
    it 'returns an xml response' do
      get feed_path(owner: 'github', repo: 'linguist')

      expect(response.content_type).to eq(Mime::Type.lookup_by_extension(:xml))
    end
  end
end

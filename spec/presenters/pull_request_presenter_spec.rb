require 'rails_helper'

describe PullRequestPresenter do
  describe 'delegations' do
    it 'delegates methods to its pull request' do
      pull_request = build(:pull_request)
      presenter = PullRequestPresenter.new(pull_request)

      expect(presenter.created_at).to eq(pull_request.created_at)
      expect(presenter.description).to eq(pull_request.description)
      expect(presenter.guid).to eq(pull_request.guid)
      expect(presenter.link).to eq(pull_request.link)
      expect(presenter.title).to eq(pull_request.title)
    end
  end

  describe '#html_description' do
    it 'converts markdown descriptions into markdown' do
      pull_request = build(:pull_request, description: 'some `code`')
      html = "<p>some <code>code</code></p>\n"

      presenter = PullRequestPresenter.new(pull_request)

      expect(presenter.html_description).to eq(html)
    end
  end
end

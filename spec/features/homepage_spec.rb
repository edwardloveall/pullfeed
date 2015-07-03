require 'rails_helper'

feature 'Guest visits homeapge' do
  scenario 'sees logo content' do
    visit '/'

    within('.logo') do
      expect(page).to have_content(I18n.t('titles.application'))
      expect(page).to have_content(I18n.t('titles.tag_line'))
    end
  end

  scenario 'sees footer content' do
    visit '/'

    within('footer') do
      expect(page).to have_content(I18n.t('strings.creator'))
      expect(page).to have_link('Source code')
    end
  end

  scenario 'gets url for repository feed', js: true do
    visit '/'
    fill_in :owner, with: 'github'
    fill_in :repository, with: 'code'

    link = find('a.feed', match: :first)

    expect(link[:href]).to match(%r{/feeds/github/code})
  end
end

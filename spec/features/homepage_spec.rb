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
end

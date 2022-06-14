# frozen_string_literal: true

require 'rails_helper'

feature 'mulitple sessions', js: true do
  given(:user) { create :user }
  given(:other_user) { create :user }

  scenario "question appears on another user's page" do
    Capybara.using_session('user') do
      sign_in_user(user)
      visit questions_path
    end

    Capybara.using_session('other_user') do
      sign_in_user(other_user)
      visit questions_path
    end

    Capybara.using_session('user') do
      click_on('Ask something')

      fill_in 'Title', with: 'Test question'
      fill_in 'Tell about your question', with: 'Test body'
      click_on 'Create Question'

      Capybara.using_session('other_user') do
        expect(page).to have_content 'Test question'
      end
    end
  end
end

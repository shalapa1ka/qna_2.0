# frozen_string_literal: true

require 'rails_helper'

feature 'Add files to answer' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in_user user
    visit question_path(question)
  end

  scenario 'User adds file to answer', js: true do
    click_on 'Answer it'
    fill_in 'Answer', with: 'My answer'
    attach_file 'Choose File', "#{Rails.root}/spec/spec_helper.rb" # FIXME: Unable to find file field "File" that is not disabled
    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end

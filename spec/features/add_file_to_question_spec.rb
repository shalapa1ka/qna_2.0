# frozen_string_literal: true

require 'rails_helper'

feature 'Add files to question' do
  given(:user) { create(:user) }

  background do
    sign_in_user user
  end

  scenario 'User adds file when asks question' do
    click_on 'Ask something'
    fill_in 'Title', with: 'Test question'
    fill_in 'Text', with: 'text text text'
    attach_file 'Choose File', "#{Rails.root}/spec/spec_helper.rb" # FIXME: Unable to find file field "File" that is not disabled
    click_on 'Create'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end

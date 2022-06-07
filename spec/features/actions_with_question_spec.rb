# frozen_string_literal: true

require 'rails_helper'

feature 'CRUD test for question', js: true do
  given(:user) { create :user }
  given(:other_user) { create :user }
  given(:admin) { create :user, :admin }
  given(:question) { create :question, user: user }

  scenario 'Signed in user creating\updating\deleting question' do
    sing_in_user user
    expect(page).to have_content 'Signed in successfully.'

    new_question
    expect(page).to have_content 'Question successfully created!'

    edit_question
    expect(page).to have_content 'Question successfully updated!'

    click_on 'Delete'
    expect(page).to have_content 'Question successfully deleted!'
  end

  scenario 'User try to edit or delete not his question' do
    sing_in_user other_user
    visit edit_question_path(question)
    expect(page).to have_content 'You are not authorized to perform this action!'
  end

  scenario 'Admin try to edit or delete not his question' do
    question
    sing_in_user admin
    edit_question
    expect(page).to have_content 'Question successfully updated!'
    expect(page).to have_content 'Edited body'
  end
end

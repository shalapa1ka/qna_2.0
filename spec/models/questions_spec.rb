# frozen_string_literal: true

require 'rails_helper'

describe Question, type: :model do
  context 'validates' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }

    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:attachments).dependent(:destroy) }

    it { should belong_to :user }

    it { should accept_nested_attributes_for :attachments }
  end
end

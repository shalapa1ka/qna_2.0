# frozen_string_literal: true

require 'rails_helper'

describe Answer, type: :model do
  context 'validates' do
    it { should validate_presence_of :body }
    it { should belong_to :question }
    it { should belong_to :user }
    it { should have_many(:attachments).dependent(:destroy) }

    it { should accept_nested_attributes_for :attachments }
  end
end

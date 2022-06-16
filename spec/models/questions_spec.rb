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

  describe 'reputation' do
    let(:user) { create(:user) }
    subject { build(:question, user: user) }
    it 'should calculate reputation after creating' do
      expect(Reputation).to receive(:calculate).with(subject)
      subject.save!
    end

    it 'should not calculate reputation after update' do
      subject.save!
      expect(Reputation).to_not receive(:calculate)
      subject.update(title: '123')
    end

    it 'test double' do
      allow(Question).to receive(:find) { double(Question, title: '123') }
      expect(Question.find(155).title).to eq '123'
    end
  end
end

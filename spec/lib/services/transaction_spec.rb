# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Transaction do
  let!(:user) { create(:user) }
  let!(:reward) { create(:reward, :standard) }
  let(:country) { nil }
  let(:amount) { 100.00 }
  let!(:transaction) { create(:transaction, :without_callbacks, user: user, amount: amount, country: country) }
  subject { described_class }

  describe '#generatable?' do
    context 'generatable' do
      context 'normal' do
        it 'is true' do
          expect(subject.new(user, amount, false).generatable?).to be_truthy
        end
      end
      context 'foreign' do
        let(:amount) { 99.99 }
        let(:country) { 'US' }
        it 'is true' do
          expect(subject.new(user, amount, true).generatable?).to be_truthy
        end
      end
    end

    context 'non generatable' do
      let(:amount) { 99.99 }
      it 'is false' do
        expect(subject.new(user, amount, false).generatable?).to be_falsey
      end
    end
  end

  describe '.execute' do
    let(:user_reward) { UserReward.last }
    let(:meta_keys) { %w[source transaction_id reward_points].sort }
    let(:args) { { user: user, amount: amount, transaction_id: transaction.id } }
    it 'generate reward' do
      expect(described_class.execute(args)).to be_truthy
      expect(user_reward.user).to eql(user)
      expect(user_reward.claimed).to be_truthy
      expect(user_reward.reward).to eql(reward)
      expect(user_reward.meta.keys.sort).to eql(meta_keys)
      expect(user_reward.meta['source']).to eql('transaction')
      expect(user_reward.meta['transaction_id']).to eql(transaction.id)
      expect(described_class.execute(args)).to be_falsey
    end
  end
end

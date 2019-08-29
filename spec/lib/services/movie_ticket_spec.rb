# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::MovieTicket do
  let!(:user) { create(:user) }
  let!(:reward) { create(:reward, :ticket) }

  subject { described_class }

  describe '#generatable?' do
    context 'generatable' do
      let!(:transactions) { create_list(:transaction, 10, user: user, amount: 100.00) }

      it 'is true' do
        expect(subject.new(user).generatable?).to be_truthy
      end
    end

    context 'non generatable' do
      let!(:transactions) { create_list(:transaction, 9, user: user, amount: 100.00) }
      it 'is false' do
        expect(subject.new(user).generatable?).to be_falsey
      end
    end
  end

  describe '.execute' do
    let!(:transactions) { create_list(:transaction, 10, user: user, amount: 100.00) }
    let(:user_reward) { UserReward.last }
    let(:meta_keys) { %w[source days sum_amount].sort }

    it 'generate reward' do
      expect(described_class.execute(user)).to be_truthy
      expect(user_reward.user).to eql(user)
      expect(user_reward.claimed).to be_falsey
      expect(user_reward.reward).to eql(reward)
      expect(user_reward.meta.keys.sort).to eql(meta_keys)
      expect(user_reward.meta['source']).to eql('movie_ticket')
      expect(described_class.execute(user)).to be_falsey
    end
  end
end

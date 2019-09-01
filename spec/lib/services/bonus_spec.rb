# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Bonus do
  let!(:user) { create(:user) }
  let!(:reward) { create(:reward, :bonus) }

  subject { described_class }

  describe '#generatable?' do
    context 'generatable' do
      before do
        Timecop.freeze(Time.zone.today.beginning_of_quarter)
        create_list(:transaction, 10, user: user, amount: 200.00)
        Timecop.return
      end

      it 'is true' do
        expect(subject.new(user).generatable?).to be_truthy
      end
    end

    context 'non generatable' do
      before do
        Timecop.freeze(Time.zone.today.beginning_of_quarter)
        create_list(:transaction, 9, user: user, amount: 200.00)
        Timecop.return
      end

      it 'is false' do
        expect(subject.new(user).generatable?).to be_falsey
      end
    end
  end

  describe '.execute' do
    let(:user_reward) { UserReward.last }
    let(:meta_keys) { %w[source sum_amount period date].sort }
    before do
      Timecop.freeze(Time.zone.today.beginning_of_quarter)
      create_list(:transaction, 10, user: user, amount: 200.00)
      Timecop.return
    end

    it 'generate reward' do
      expect(described_class.execute(user)).to be_truthy
      expect(user_reward.user).to eql(user)
      expect(user_reward.claimed).to be_falsey
      expect(user_reward.reward).to eql(reward)
      expect(user_reward.meta.keys.sort).to eql(meta_keys)
      expect(user_reward.meta['source']).to eql('bonus')
      expect(described_class.execute(user)).to be_falsey
    end
  end
end

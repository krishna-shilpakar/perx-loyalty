# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Birthday do
  let!(:user) { create(:user, date_of_birth: DateTime.current.last_year) }
  let!(:reward) { create(:reward, :coffee) }

  subject { described_class }

  describe '#generatable?' do
    context 'generatable' do
      before { Timecop.freeze(DateTime.current.beginning_of_month) }
      after { Timecop.return }
      it 'is true' do
        expect(subject.new(user).generatable?).to be_truthy
      end
    end

    context 'non generatable' do
      before { Timecop.travel(DateTime.current.next_month) }
      after { Timecop.return }
      it 'is false' do
        expect(subject.new(user).generatable?).to be_falsey
      end
    end
  end

  describe '.execute' do
    let(:user_reward) { UserReward.last }
    let(:meta_keys) { %w[source year].sort }
    before { Timecop.freeze(DateTime.current.beginning_of_month) }
    after { Timecop.return }

    it 'generate reward' do
      expect(described_class.execute(user)).to be_truthy
      expect(user_reward.user).to eql(user)
      expect(user_reward.claimed).to be_falsey
      expect(user_reward.reward).to eql(reward)
      expect(user_reward.meta.keys.sort).to eql(meta_keys)
      expect(user_reward.meta['source']).to eql('birthday')
      expect(described_class.execute(user)).to be_falsey
    end
  end
end

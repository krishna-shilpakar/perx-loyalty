# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rewards::Transaction do
  describe 'instance_methods' do
    let!(:user) { create(:user) }
    let(:amount) { 101 }
    let(:foreign) { false }
    let!(:reward) { create(:reward, :standard) }
    subject { described_class.new(user, amount, foreign) }

    describe '#generatable?' do
      context 'generatable' do
        let(:amount) { 101 }
        let(:foreign) { true }
        it 'is true' do
          expect(subject.generatable?).to be_truthy
        end
      end

      context 'non generatable' do
        let(:amount) { 90 }
        let(:foreign) { false }
        it 'is false' do
          expect(subject.generatable?).to be_falsey
        end
      end
    end

    describe '#award_reward!' do
      let(:point) { Point.last }
      let(:user_reward) { UserReward.last }

      it 'creates points and claims' do
        expect { subject.award_reward! }
          .to change(Point, :count).from(0).to(1)
                                   .and change(UserReward, :count).from(0).to(1)
        expect(point.num).to eql(10)
        expect(point.user_reward).to eql(user_reward)
        expect(user_reward.claimed).to be_truthy
        expect(user.reload.loyalty_points).to eql(10)
      end
    end

    describe '#reward_points' do
      context 'foreign spending' do
        let(:foreign) { true }
        it 'is 20 points' do
          expect(subject.send(:reward_points)).to eql(20)
        end
      end

      context 'normal spending' do
        it 'is 10 points' do
          expect(subject.send(:reward_points)).to eql(10)
        end
      end
    end
  end

  describe '.generate!' do
    let(:user) { create(:user) }
    let!(:reward) { create(:reward, :standard) }
    let(:point) { Point.last }
    let(:user_reward) { UserReward.last }

    subject { described_class }
    it 'generate reward' do
      expect(described_class.generate!(user: user, amount: 101)).to be_truthy
      expect(Point.count).to eq(1)
      expect(UserReward.count).to eq(1)
      expect(point.num).to eql(10)
      expect(point.user_reward).to eql(user_reward)
      expect(user_reward.claimed).to be_truthy
    end
  end
end

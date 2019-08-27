# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0.0) }
  end

  describe '#transaction_reward' do
    let(:user) { create(:user) }
    let!(:reward) { create(:reward, :standard) }
    let(:point) { Point.last }
    let(:user_reward) { UserReward.last }
    let(:amount) { 101 }
    let(:country) { nil }
    let!(:transaction) do
      build(:transaction, user: user, amount: amount, country: country)
    end

    context 'transaction amount > 100.00' do
      it 'creates and claim rewards' do
        expect { transaction.save! }
          .to change(Point, :count).from(0).to(1)
                                   .and change(UserReward, :count).from(0).to(1)
        expect(point.num).to eql(10)
        expect(point.user_reward).to eql(user_reward)
        expect(user_reward.claimed).to be_truthy
        expect(user.reload.loyalty_points).to eql(10)
      end
    end
    context 'foreign spending' do
      let(:country) { 'US' }
      it 'creates and claim rewards' do
        expect { transaction.save! }
          .to change(Point, :count).from(0).to(1)
                                   .and change(UserReward, :count).from(0).to(1)
        expect(point.num).to eql(20)
        expect(point.user_reward).to eql(user_reward)
        expect(user_reward.claimed).to be_truthy
        expect(user.reload.loyalty_points).to eql(20)
      end
    end
    context 'regular spending and amount < 100.00' do
      let(:amount) { 90 }
      it 'will not creates and not claim rewards' do
        expect { transaction.save! }
          .to change(Point, :count).by(0)
                                   .and change(UserReward, :count).by(0)
        expect(user.reload.loyalty_points).to eql(0)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#expire_points' do
    let!(:user) { create(:user, loyalty_points: 1500, tier: Tier.platinum) }
    it 'reset points' do
      expect(user.expire_points!).to be_truthy
      expect(user.reload.loyalty_points).to eq(0)
      expect(user.tier).to eql(Tier.default)
    end
    context 'gold tier' do
      before do
        Timecop.freeze(30.months.ago)
        create_list(:point, 15, user: user, num: 50)
        Timecop.return
        Timecop.freeze(15.months.ago)
        create_list(:point, 15, user: user, num: 100)
        Timecop.return
      end
      it 'reset and set tier to gold' do
        expect(user.expire_points!).to be_truthy
        expect(user.reload.loyalty_points).to eq(0)
        expect(user.tier).to eql(Tier.gold)
      end
    end
    context 'platinum tier' do
      before do
        Timecop.freeze(30.months.ago)
        create_list(:point, 15, user: user, num: 50)
        Timecop.return
        Timecop.freeze(15.months.ago)
        create_list(:point, 15, user: user, num: 1000)
        Timecop.return
      end
      it 'reset and set tier to gold' do
        expect(user.expire_points!).to be_truthy
        expect(user.reload.loyalty_points).to eq(0)
        expect(user.tier).to eql(Tier.platinum)
      end
    end
  end

  describe '#set_tier' do
    let!(:user) { create(:user) }
    context '0..999' do
      before { user.update(loyalty_points: 800) }
      it 'user is on standard tier' do
        expect(user.reload.tier).to eql(Tier.standard)
      end
    end
    context '1000...4999' do
      before { user.update(loyalty_points: 1000) }
      it 'user is on gold tier' do
        expect(user.reload.tier).to eql(Tier.gold)
      end
    end
    context '5000..up' do
      before { user.update(loyalty_points: 5000) }
      it 'user is on platinum tier' do
        expect(user.reload.tier).to eql(Tier.platinum)
      end
    end
  end
end

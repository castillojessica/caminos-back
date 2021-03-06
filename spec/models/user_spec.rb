require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'associations' do
    it { is_expected.to have_one(:profile) }
    it { is_expected.to belong_to(:entity) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'instance method' do
    let(:user){ create(:user_with_profile) }

    it('avatar_url') { expect(user.avatar_url).to be_present }
    it('color') { expect(user.color).to be_present }
  end

  describe 'roles' do
    let(:responsible){ create(:responsible) }
    let(:admin){ create(:admin) }

    it('check responsible role') { expect(responsible.roles).to contain_exactly(:responsible) }
    it('check admin role') { expect(admin.roles).to contain_exactly(:admin) }
  end

end

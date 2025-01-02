require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { create(:user) }

  context 'associations' do
    it 'has a valid empty sessions array association' do
      expect(user.sessions).to eq([])
    end

    it 'has a valid sessions array association' do
      user.sessions.create
      expect(user.sessions.count).to eq(1)
      expect(user.sessions.first.user).to eq(user)
    end
  end

  context 'basic attributes' do
    it 'has a valid first name' do
      expect(user.first_name).to eq('Test')
    end

    it 'has a valid last name' do
      expect(user.last_name).to eq('User')
    end

    it 'has a valid full name' do
      expect(user.full_name).to eq('Test User')
    end
  end

  context 'email normalization' do
    it 'normalizes the email address before saving' do
      user.email_address = ' TeSt@test.COM '
      expect(user.email_address).to eq('test@test.com')
    end
  end

  context 'password security' do
    it 'has a secure password' do
      expect(user.authenticate('password')).to be_truthy
    end

    it 'does not authenticate with an incorrect password' do
      expect(user.authenticate('wrong_password')).to be_falsey
    end
  end
end

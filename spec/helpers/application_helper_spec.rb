require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_date' do
    let(:date) { Date.new(2021, 10, 1) }

    context 'when the user has a GB locale' do
      let(:user) { double('User', locale: 'gb') }

      before do
        allow(Current).to receive(:user).and_return(user)
      end

      it 'formats the date based on the user as GB' do
        expect(helper.format_date(date)).to eq('01/10/2021')
      end
    end

    context 'when the user has a US locale' do
      let(:user) { double('User', locale: 'us') }

      before do
        allow(Current).to receive(:user).and_return(user)
      end

      it 'formats the date based on the user as US' do
        expect(helper.format_date(date)).to eq('10/01/2021')
      end
    end

    context 'when the user does not have a locale' do
      let(:user) { double('User', locale: nil) }

      before do
        allow(Current).to receive(:user).and_return(user)
      end

      it 'formats the date based on the default locale' do
        expect(helper.format_date(date)).to eq('2021/10/01')
      end
    end
  end

  describe '#flash_class' do
    BASE_CLASS = "flash-message fixed top-24 left-1/2 transform -translate-x-1/2 px-4 py-3 rounded mb-4 max-w-lg shadow-lg z-50 flex justify-between items-center".freeze

    context 'when the key is notice' do
      it 'returns the notice class' do
        expect(helper.flash_class('notice')).to eq("#{BASE_CLASS} bg-green-100 border border-green-400 text-green-700")
      end
    end

    context 'when the key is alert' do
      it 'returns the alert class' do
        expect(helper.flash_class('alert')).to eq("#{BASE_CLASS} bg-red-100 border border-red-400 text-red-700")
      end
    end

    context 'when the key is not notice or alert' do
      it 'returns the base class' do
        expect(helper.flash_class('other')).to eq(BASE_CLASS)
      end
    end
  end
end

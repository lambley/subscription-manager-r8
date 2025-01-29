require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_date' do
    let(:date) { Date.new(2021, 10, 1) }

    context 'when the user is present' do
      include_examples 'formats date based on locale', 'gb', '01/10/2021'
      include_examples 'formats date based on locale', 'us', '10/01/2021'
    end

    context 'when the user is not present' do
      let (:user) { nil }

      before do
        allow(Current).to receive(:user).and_return(user)
      end

      it 'formats the date based on the default locale' do
        expect(helper.format_date(date)).to eq('2021/10/01')
      end
    end
  end

  describe '#flash_class' do
    context 'when the key is notice' do
      it 'returns the notice class' do
        expect(helper.flash_class('notice')).to eq('flash-message fixed top-4 left-1/2 transform -translate-x-1/2 px-4 py-3 rounded relative mb-4 max-w-lg shadow-lg z-50 bg-green-100 border border-green-400 text-green-700')
      end
    end

    context 'when the key is alert' do
      it 'returns the alert class' do
        expect(helper.flash_class('alert')).to eq('flash-message fixed top-4 left-1/2 transform -translate-x-1/2 px-4 py-3 rounded relative mb-4 max-w-lg shadow-lg z-50 bg-red-100 border border-red-400 text-red-700')
      end
    end

    context 'when the key is not notice or alert' do
      it 'returns the base class' do
        expect(helper.flash_class('other')).to eq('flash-message fixed top-4 left-1/2 transform -translate-x-1/2 px-4 py-3 rounded relative mb-4 max-w-lg shadow-lg z-50')
      end
    end
  end
end

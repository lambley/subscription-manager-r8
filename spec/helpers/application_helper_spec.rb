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
end

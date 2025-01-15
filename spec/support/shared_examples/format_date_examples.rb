RSpec.shared_examples 'formats date based on locale' do |locale, expected_format|
  let(:user) { create(:user) }

  before do
    allow(Current).to receive(:user).and_return(user)
  end

  it "formats the date for locale #{locale}" do
    user.update(locale: locale)
    expect(helper.format_date(date)).to eq(expected_format)
  end
end

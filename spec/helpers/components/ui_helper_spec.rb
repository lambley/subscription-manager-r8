require 'rails_helper'

RSpec.describe Components::UiHelper, type: :helper do
  describe '#render_card' do
    it 'renders the card partial with the correct locals' do
      title = "Test Title"
      subtitle = "Test Subtitle"
      body = "Test Body"

      expect(helper).to receive(:render).with(partial: 'components/ui/card', locals: { title: title, subtitle: subtitle, body: body })

      helper.render_card(title: title, subtitle: subtitle, body: body)
    end
  end
end

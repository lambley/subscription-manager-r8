require 'rails_helper'

RSpec.describe Components::UiHelper, type: :helper do
  describe '#render_card' do
    it 'renders the card partial with the correct locals' do
      title = "Test Title"
      subtitle = "Test Subtitle"
      body = "Test Body"

      expect(helper).to receive(:render).with(partial: 'components/ui/card', locals: { title: title, subtitle: subtitle, body: body })

      helper.render_card(title: title, subtitle: subtitle) { body }
    end

    it 'renders the card partial without a subtitle' do
      title = "Test Title"
      body = "Test Body"

      expect(helper).to receive(:render).with(partial: 'components/ui/card', locals: { title: title, subtitle: nil, body: body })

      helper.render_card(title: title, subtitle: nil) { body }
    end

    it 'renders the card partial without a title' do
      subtitle = "Test Subtitle"
      body = "Test Body"

      expect(helper).to receive(:render).with(partial: 'components/ui/card', locals: { title: nil, subtitle: subtitle, body: body })

      helper.render_card(title: nil, subtitle: subtitle) { body }
    end
  end

  describe '#render_button' do
    it 'renders the button partial with the correct locals for link_to' do
      text = "Click Me"
      icon = "fa-icon"
      link = "/path"
      button_type = "link_to"
      method = :get
      data = { controller: "example", action: "click->example#action" }
      bg_class = "bg-blue-500"
      options = { class: "extra-class" }

      expect(helper).to receive(:render).with(partial: 'components/ui/button', locals: { text: text, icon: icon, link: link, button_type: button_type, method: method, data: data, bg_class: bg_class, options: options })

      helper.render_button(text: text, icon: icon, link: link, button_type: button_type, method: method, data: data, bg_class: bg_class, **options)
    end

    it 'renders the button partial with the correct locals for button_to' do
      text = "Submit"
      icon = "fa-icon"
      link = "/submit"
      button_type = "button_to"
      method = :post
      data = { controller: "example", action: "submit->example#action" }
      bg_class = "bg-green-500"
      options = { class: "extra-class" }

      expect(helper).to receive(:render).with(partial: 'components/ui/button', locals: { text: text, icon: icon, link: link, button_type: button_type, method: method, data: data, bg_class: bg_class, options: options })

      helper.render_button(text: text, icon: icon, link: link, button_type: button_type, method: method, data: data, bg_class: bg_class, **options)
    end

    it 'renders the button partial with the correct locals for submit' do
      text = "Save"
      button_type = "submit"
      bg_class = "bg-red-500"
      options = { class: "extra-class" }

      expect(helper).to receive(:render).with(partial: 'components/ui/button', locals: { text: text, icon: nil, link: "#", button_type: button_type, method: nil, data: nil, bg_class: bg_class, options: options })

      helper.render_button(text: text, button_type: button_type, bg_class: bg_class, **options)
    end
  end
end

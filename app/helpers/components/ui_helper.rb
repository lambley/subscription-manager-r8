module Components::UiHelper
  def render_card(title:, subtitle:, &block)
    render partial: "components/ui/card", locals: { title: title, subtitle: subtitle, body: capture(&block) }
  end

  def render_button(text:, icon: nil, link: "#", button_type: "link_to", method: nil, data: nil, bg_class: nil, **options)
    render partial: "components/ui/button", locals: { text: text, icon: icon, link: link, button_type: button_type, method: method, data: data, bg_class: bg_class, options: options }
  end
end

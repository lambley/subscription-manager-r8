module Components::UiHelper
  def render_card(title:, subtitle:, &block)
    render partial: "components/ui/card", locals: { title: title, subtitle: subtitle, body: capture(&block) }
  end

  def render_button(text:, icon: nil, link: "#", button_type: "link_to", method: nil, data: nil, bg_class: "bg-main", **options)
    render partial: "components/ui/button", locals: { text: text, icon: icon, link: link, button_type: button_type, method: method, data: data, bg_class: bg_class, options: options }
  end

  def render_input(name:, placeholder: nil, type: "text", value: nil, **options)
    render partial: "components/ui/input", locals: { name: name, placeholder: placeholder, type: type, value: value, options: options }
  end
end

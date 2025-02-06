module Components::UiHelper
  def render_card(title:, subtitle:, &block)
    render partial: "components/ui/card", locals: { title: title, subtitle: subtitle, body: capture(&block) }
  end

  def render_button(text:, icon: nil, link: "#", button_type: "link_to", method: nil, data: {}, bg_class: "bg-main", **options)
    render partial: "components/ui/button", locals: { text: text, icon: icon, link: link, button_type: button_type, method: method, data: data, bg_class: bg_class, options: options }
  end

  def render_input(name:, placeholder: nil, type: "text", value: nil, **options)
    render partial: "components/ui/input", locals: { name: format_label(name), placeholder: placeholder, type: type, value: value, options: options }
  end

  def render_link(text:, url:, target:)
    render partial: "components/ui/link", locals: { text: text, url: url, target: target }
  end

  def render_badge(text:, bg_class: "bg-main", text_class: "text-white")
    render partial: "components/ui/badge", locals: { text: text, bg_class: bg_class, text_class: text_class }
  end

  def collapsible_preview(&block)
    content_for :preview, capture(&block) if block
  end

  def collapsible_body(&block)
    content_for :body, capture(&block) if block
  end

  def render_collapsible(**options, &block)
    content = capture(&block) if block
    render "components/ui/collapsible", content: content, **options
  end

  private

  def format_label(label)
    # if label is in the form object[field], return field,
    # otherwise return label
    if label.to_s.include?("[") && label.to_s.include?("]")
      label.to_s.split("[").last.split("]").first
    else
      label
    end
  end
end

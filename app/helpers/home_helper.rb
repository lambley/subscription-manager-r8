module HomeHelper
  def render_card(title:, subtitle:, body:)
    render partial: 'components/ui/card', locals: { title: title, subtitle: subtitle, body: body }
  end
end

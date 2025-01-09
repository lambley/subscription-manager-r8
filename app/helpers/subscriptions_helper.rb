module SubscriptionsHelper
  def add_is_active_badge(is_active)
    if is_active
      content_tag(:span, 'Active', class: 'bg-green-500 text-white px-2 py-1 rounded-full')
    else
      content_tag(:span, 'Inactive', class: 'bg-red-500 text-white px-2 py-1 rounded-full')
    end
  end
end

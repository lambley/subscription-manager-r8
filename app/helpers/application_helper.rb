module ApplicationHelper
  def format_date(date)
    if Current.user && Current.user.locale
      date.strftime(I18n.t("date.formats.#{Current.user.locale}"))
    else
      date.strftime(I18n.t("date.formats.default"))
    end
  end

  def flash_class(key)
    base_class = "flash-message fixed top-4 left-1/2 transform -translate-x-1/2 px-4 py-3 rounded relative mb-4 max-w-lg shadow-lg z-50"
    case key
    when "notice"
      "#{base_class} bg-green-100 border border-green-400 text-green-700"
    when "alert"
      "#{base_class} bg-red-100 border border-red-400 text-red-700"
    else
      base_class
    end
  end
end

module ApplicationHelper
  def format_date(date)
    if Current.user && Current.user.locale
      date.strftime(I18n.t("date.formats.#{Current.user.locale}"))
    else
      date.strftime(I18n.t("date.formats.default"))
    end
  end
end

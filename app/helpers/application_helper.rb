module ApplicationHelper
  def format_date(date)
    # default to YYYY-MM-DD
    date.strftime('%Y-%m-%d')
  end
end

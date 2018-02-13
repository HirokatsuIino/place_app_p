Time::DATE_FORMATS.merge!(
  default:       '%Y-%m-%d %H:%M',
  default_date:  '%Y-%m-%d',
  datetime:      '%Y/%m/%d %H:%M',
  datetime_jp:   '%Y年%m月%d日 %H時%M分',
  date:          '%Y/%m/%d',
  date_jp:       '%Y年%m月%d日',
  year_month:    '%Y/%m',
  year_month_jp: '%Y年%m月',
  year:          '%Y',
  year_jp:       '%Y年',
  short_date:    '%m/%d',
  short_date_jp: '%m月%d日',
  time:          '%H:%M',
  time_jp:       '%H時%M分',
  wday_jp: lambda { |t| t.strftime("#{%w(日 月 火 水 木 金 土)[t.wday]}") }
)

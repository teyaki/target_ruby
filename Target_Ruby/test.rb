require 'nokogiri'
require 'open-uri'
require 'active_support/all'
require 'kconv'

date = Date.new(2014, 10, 4).end_of_week
# 土曜日

#date = date.next_week(:saturday)
year = date.year
month = date.strftime("%m")
up_month = month
day = date.strftime("%d")

if date.prev_week.month != up_month
  up_month = date.prev_week.strftime("%m")
end

p year
p month
p up_month
p day

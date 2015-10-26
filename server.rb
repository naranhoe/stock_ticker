require 'httparty'
require 'json'
require 'nokogiri'
require 'sinatra'

response_for_yahoo = HTTParty.get("http://finance.yahoo.com/q?s=aapl")
# stock_symbol = HTTParty.get("http://www.marketwatch.com/investing/stock/#{user_entry}")
dom = Nokogiri::HTML(response_for_yahoo.body)

current_stock = dom.xpath("//span[@id='yfs_l84_aapl']")
prev_close = dom.xpath("//td[@class='yfnc_tabledata1']")
# ** Cannot figure out how to display company name properly
company = dom.xpath("//div[@class='title']/h2")

get '/stock_ticker' do
  "Apple Inc. (AAPL): $#{current_stock.first.content}"
end

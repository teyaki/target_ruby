require 'nokogiri'
require 'open-uri'
require 'active_support/all'
require 'kconv'

#http://uma-blo.com/bc2012/wp-content/uploads/2014/01/BC20140105.csv

class BCDownloader
  def initialize(year)
    @year = year.to_i
    @read_root = "http://uma-blo.com/bc2012/wp-content/uploads"
    @write_root = "C:/TFJV/BCindex"


    exec_download(:saturday)
    exec_download(:sunday)
  end

  private

  def exec_download(day_of_week)
    date = Date.new(@year, 1, 1).end_of_week
    if day_of_week == :saturday
      date = date - 1
    end

    # 土曜日
    while true
      sleep(2)
      if date.year > @year
        break
      end
      open_url(date)
      date = date.next_week(day_of_week)
    end
  end

  def open_url(date)
    year = date.year
    month = date.strftime("%m")
    day = date.strftime("%d")
    download_url = "#{@read_root}/#{year}/#{month}/BC#{year}#{month}#{day}.csv"
    file_name = File.basename(download_url)
    open("#{@write_root}/#{file_name}", 'wb') do |output|
      begin
        open(download_url) do |data|
          output.write(data.read)
        end
      rescue
        up_month = (date.prev_month).strftime("%m")
        download_url = "#{@read_root}/#{year}/#{up_month}/BC#{year}#{month}#{day}.csv"
        begin
          open(download_url) do |data|
            output.write(data.read)
          end
        rescue
          p "fatal_error"
        end
      end
    end
    p download_url
  end

end

if $0 == __FILE__
  if ARGV.size() == 1
    year = ARGV[0].toutf8
  else
    print "arg1 -> 年: yyyy\n"
    exit
  end
  BCDownloader.new(year)
end

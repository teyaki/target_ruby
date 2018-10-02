require 'kconv'
require 'csv'
require 'active_support/all'
require_relative 'score.rb'
require_relative 'export_csv.rb'

class Main
  def initialize(date)
    get_all_file_name(date).each do |row|
      data = Score.new().get_data(row.to_path)
      ExportCSV.new(date).exec(data)
    end
  end

  private

  def get_all_file_name(date)
    Pathname.glob("./race_list/#{date}/*").map()
  end

end

if $0 == __FILE__
  if ARGV.size() == 1
    date = ARGV[0].toutf8
  else
    print "arg1 -> レース日: yyyymmdd\n"
    exit
  end

  Main.new(date)
end

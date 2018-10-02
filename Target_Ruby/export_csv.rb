require 'kconv'
require 'csv'
require 'active_support/all'

class ExportCSV
  def initialize(date)
    @export_file_name = "BS#{date}.csv"
  end

  def exec(data)
    CSV.open("C:/TFJV/BS/#{@export_file_name}", 'a') do |row|
      row << data
    end
  end
end

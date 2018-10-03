require 'kconv'
require 'csv'
require 'active_support/all'

class CSVExport
  def initialize(file_name)
    @file_path = "../../TFJV/DG/#{file_name}"
    if File.exist?(@file_path)
      File.delete(@file_path)
    end
  end

  def exec(data)
    CSV.open(@file_path, 'a') do |row|
      row << data
    end
  end
end

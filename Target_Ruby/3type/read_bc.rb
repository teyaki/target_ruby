require 'kconv'
require 'csv'
require 'active_support/all'

class ReadBC

  def initialize
    get_all_file_name.each do |row|
      p File.basename(row)
    end
  end

  def get_all_file_name
    Pathname.glob("C:/TFJV/BCindex/*").map()
  end

end

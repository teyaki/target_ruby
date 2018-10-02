require 'kconv'
require 'csv'
require 'active_support/all'
require_relative 'csv_analyzer.rb'

class Main
  def initialize
    CSVAnalyzer.new
  end

end

if $0 == __FILE__
  Main.new
end

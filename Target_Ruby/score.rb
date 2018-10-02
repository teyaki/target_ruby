require 'csv'
require "kconv"
require_relative 'scan_blood.rb'

class Score

  def initialize()
  end

  def get_data(file_name)
    klass = nil
    data = []
    horse_count = 0
    File.open(file_name, encoding: "Shift_JIS:UTF-8") do |file|
      file.readline # skip header
      file.each_line do |line|
        race_info = line.split(",")
        data << race_info[0]
        klass = ScanBlood.new(race_info)
        break
      end
      file.readline # skip header
      file.each_line do |line|
        line = line.gsub(/[\r\n]/,"")
        split = line.split(",")
        score = 0
        score += klass.scan_sire_type(split[2], split[3])
        score += klass.scan_broodmare_type(split[4], split[5])
        data << score.round(2)
      end
    end

    return data
  end
end

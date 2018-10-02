require 'csv'
require "kconv"

class ScanBlood

  def initialize(race_info)
    @condition = race_info[4]
    @dir = "./target_list/#{race_info[1]}/#{race_info[3]}/#{race_info[2]}"
    if File.directory?(@dir) == false
      p "directory is not exist"
      exit
    end
  end

  def scan_sire_type(target, target_line)
    score = scan_sire(target)
    if score == 0
      score = scan_sire_line(target_line)
    end
    return score
  end

  def scan_broodmare_type(target, target_line)
    score = scan_broodmare_sire(target)
    if score == 0
      score = scan_broodmare_sire_line(target_line)
    end
    return score
  end

  private

  def scan_sire(target)
    calc_score(scan("父"), target)
  end

  def scan_sire_line(target)
    calc_score(scan("父系"), target)
  end

  def scan_broodmare_sire(target)
    calc_score(scan("母父"), target)
  end

  def scan_broodmare_sire_line(target)
    calc_score(scan("母父系"), target)
  end

  def scan(file_name)
    file_path = "#{@dir}/#{@condition}/#{file_name}.csv".gsub(/[\r\n]/,"")
    csv_data = CSV.read(file_path, headers: true, encoding: "Shift_JIS:UTF-8")
  end

  def calc_score(csv_data, target)
    score = 0
    csv_data.each do |row|
      if row[1] == target
        md = /\//.match(row[2])
        entry_count = md.post_match.to_i
        if entry_count < 10
          next
        end
        score += row[3].to_f
        score += row[4].to_f
        score += row[5].to_f
        break
      end
    end
    return score
  end
end

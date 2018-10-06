require 'kconv'
require 'csv'
require 'active_support/all'
require_relative 'csv_export.rb'
require_relative 'race_id_converter.rb'

class CSVAnalyzer
  def initialize
    exec
  end

  private

  def exec
    all_file_name = get_all_file_name
    all_file_name.each do |file|
      analyze(file)
    end
  end

  def get_all_file_name
    Pathname.glob("./csv/*").map()
  end

  def analyze(file)
    file_path = file.to_path
    file_name = File.basename(file)
    klass = CSVExport.new(file_name)
    csv_data = CSV.read(file_path, encoding: "Shift_JIS:UTF-8")
    insert_data = []
    csv_data.each do |row|
      if row[0].to_i > 20  # レースID
        insert_csv(klass, insert_data)
        insert_data = []
        insert_data << row[0]
        next
      end
      bc = row[4].to_f
      if bc == 0.0
        insert_data = []
        next
      end
      # 対戦型マイニング + BCIndex
      data = row[3].to_f + bc
      insert_data << data
    end

    insert_csv(klass, insert_data)
  end

  def insert_csv(klass, insert_data)
    klass.exec(insert_data)
  end
end

require 'kconv'
require 'csv'
require 'active_support/all'
require_relative 'csv_export.rb'

#pp:場所コード,yy:西暦下2桁,yyyy:西暦,mm:月,dd:日
#k・kk:回次,n・nn:日次,rr:レース番号,uu:馬番

# 旧仕様	8桁	ppyyknrr
# 旧仕様馬番付き	10桁	ppyyknrruu
# 新仕様	16桁	yyyymmddppkknnrr
# 新仕様馬番付き	18桁	yyyymmddppkknnrruu
# 第３仕様	12桁	yyyymmddpprr
# 第３仕様馬番付き	14桁	yyyymmddpprruu

class RaceIdConverter
  def initialize

  end

  def to_old_id(new_id)
    pp = new_id[9]
    yy = "#{new_id[2]}#{new_id[3]}"
    k = new_id[11]
    n = new_id[13]
    rr = "#{new_id[14]}#{new_id[15]}"

    "#{pp}#{yy}#{k}#{n}#{rr}"
  end
end

#p RaceIdConverter.new.to_old_id("2014122806040800")

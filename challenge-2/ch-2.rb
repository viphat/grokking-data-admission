require 'csv'

class GrokkingCh2

  HCM = [
    'tphcm', 'gò vấp', 'bình chánh', 'binh tan', 'bình tân', 'củ chi', 'ho chi minh city',
    'hcmc', 'hcm', 'ho chi minh', 'hochiminh', 'hồ chí minh', 'quận 7', 'quận 8', 'tân phú',
    'sai gon', 'saigon', 'sài gòn', 'thủ đức', 'thanh pho ho chi minh', 'tp.hcm', 'tp hcm', 'tp. ho chi minh',
    'tp hồ chí minh', 'thanh pho hcm', 'thành phố hồ chí minh', 'tp. hồ chí minh', 'tp ho chi minh'
  ]

  HN = [
    'hn', 'ba đình', 'cầu giấy', 'hà đông', 'ha noi', 'hà nội', 'hà tây', 'hai bà trưng',
    'hanoi', 'thanh pho ha noi', 'mê linh', 'thanh xuân'
  ]

  def initialize
    @input_csv_file = "/Users/viphat/projects/ruby/grokking-data/challenge-2/data-input.csv"
    @cleaned_csv_file = "/Users/viphat/projects/ruby/grokking-data/challenge-2/data-cleaned.csv"
  end


  def cleaning_data(row)
    return if row["Province"].nil?
    # Clean Data for Province HCM
    row["Province"] = "Ho Chi Minh City" if HCM.include?(row["Province"].downcase.split(" ").join(" "))
    row["Province"] = "Ha Noi" if HN.include?(row["Province"].downcase.split(" ").join(" "))
  end

  def write_header_to_cleaned_file
    row = %w(Recruited Gender Age Province Country)
    write_to_cleaned_file(row)
  end

  def write_to_cleaned_file(row)
    # a is append
    CSV.open(@cleaned_csv_file, "a") do |writer|
      writer << row
    end
  end

  def read_and_clean_data
    CSV.foreach(@input_csv_file, headers: true) do |row|
      cleaning_data(row)
      write_to_cleaned_file(row)
    end
  end

  def excute
    write_header_to_cleaned_file
    read_and_clean_data
  end

end

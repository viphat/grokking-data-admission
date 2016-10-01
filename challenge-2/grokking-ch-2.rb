# Answer of 2.1 is 1842 people
# Answer of 2.2 is 2441 people
# For 2.3, please see results at link https://github.com/viphat/grokking-data-admission/blob/master/challenge-2/c2-3.csv
# For 2.4, please see results at link https://github.com/viphat/grokking-data-admission/blob/master/challenge-2/c2-4.csv

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
    path = "/Users/viphat/projects/ruby/grokking-data/challenge-2"
    @input_csv_file = "#{path}/data-input.csv"
    @cleaned_csv_file = "#{path}/data-cleaned.csv"
    @file_c2_3 = "#{path}/c2-3.csv"
    @file_c2_4 = "#{path}/c2-4.csv"
  end

  def excute!
    # Data Cleaning
    write_header_to_csv_file(@cleaned_csv_file)
    manipulate_and_clean_data

    # How many people are older than Mark Zuckerberg
    set_mark_zuckerberg_age
    p count_number_of_people_are_older_than_mark_zuckerberg

    # How many people are living in Ho Chi Minh City
    p count_number_of_people_are_living_in_hcm

    # The list of people who live in Ho Chi Minh City, age less than 20 and gender is 'female'
    export_list_of_people_c2_3

    # The list of people who recruited on weekend from 6PM to 10PM, live in Ho Chi Minh City or Ha Noi City
    export_list_of_people_c2_4
  end

  private

    def cleaning_data(row)
      return if row["Province"].nil?
      row["Province"] = "Ho Chi Minh City" if HCM.include?(row["Province"].downcase.split(" ").join(" "))
      row["Province"] = "Ha Noi City" if HN.include?(row["Province"].downcase.split(" ").join(" "))
    end

    def write_header_to_csv_file(file)
      row = %w(Date\ Recruited Gender Age Province Country)
      write_data_to_csv_file(file, row, "w")
    end

    def write_data_to_csv_file(file, row, write_option="a")
      CSV.open(file, write_option) do |writer|
        writer << row
      end
    end

    def manipulate_and_clean_data
      CSV.foreach(@input_csv_file, headers: true) do |row|
        cleaning_data(row)
        write_data_to_csv_file(@cleaned_csv_file, row)
      end
    end

    def set_mark_zuckerberg_age
      @mark_age = Time.now.year - Date.strptime("05-14-1984", "%m-%d-%Y").year
    end

    def count_number_of_people_are_older_than_mark_zuckerberg
      # 2.1
      older_than_mark_count = 0
      CSV.foreach(@cleaned_csv_file, headers: true) do |row|
        next if row["Age"].nil?
        older_than_mark_count += 1 if row["Age"].to_i > @mark_age
      end
      older_than_mark_count
    end

    def count_number_of_people_are_living_in_hcm
      # 2.2
      count = 0
      CSV.foreach(@cleaned_csv_file, headers: true) do |row|
        next if row["Province"].nil?
        count += 1 if row["Province"] == "Ho Chi Minh City"
      end
      count
    end

    def export_list_of_people_c2_3
      # 2.3
      write_header_to_csv_file(@file_c2_3)
      CSV.foreach(@cleaned_csv_file, headers: true) do |row|
        next if row["Gender"].nil?
        next if row["Province"].nil?
        next if row["Age"].nil?
        write_data_to_csv_file(@file_c2_3, row) if row["Province"] == "Ho Chi Minh City" &&
          row["Age"].to_i < 20 && row["Gender"].downcase.split(" ").join(" ") == "female"
      end
    end

    def export_list_of_people_c2_4
      # 2.4
      write_header_to_csv_file(@file_c2_4)
      CSV.foreach(@cleaned_csv_file, headers: true) do |row|
        next if row["Province"].nil?
        next if row["Date Recruited"].nil?
        date_recruited = DateTime.strptime(row["Date Recruited"].split(" ").join(" "),"%Y-%m-%d %H:%M")
        next unless (date_recruited.saturday? || date_recruited.sunday?)
        next unless (date_recruited.hour >= 18 && date_recruited.hour < 23)
        next unless (row["Province"] == "Ho Chi Minh City" || row["Province"] == "Ha Noi City")
        write_data_to_csv_file(@file_c2_4, row)
      end
    end

end

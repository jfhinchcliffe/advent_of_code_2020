require_relative "../file_loader.rb"

all_lines = FileLoader.new("./day_4/input.txt").lines(->(x) { x })

class PassportValidator

  REQUIRED_KEYS = %w{iyr ecl eyr pid hcl byr hgt}

  def self.valid?(data_line)
    args = data_line.split.map{|d| d.split(":")}.to_h
    (REQUIRED_KEYS - args.keys).empty?
  end
end

class PassportLoader
  def self.from_data(file_lines)
    clean_data(file_lines).map do |passport_data|
      PassportValidator.valid?(passport_data)
    end
  end

  private

  def self.clean_data(file_lines)
    file_lines.inject([""]) do |acc, line|
      line.length == 1 ? acc << "" : acc.last << " #{line.delete("\n")}"
      acc
    end
  end
end

part_one_results =  PassportLoader.from_data(all_lines).select{ |e| e }.length
puts "Part 1 answer: #{part_one_results}" # 228
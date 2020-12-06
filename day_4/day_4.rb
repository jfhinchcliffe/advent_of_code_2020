require_relative "../file_loader.rb"

all_lines = FileLoader.new("./day_4/input.txt").lines(->(x) { x })

class PassPort

  def initialize(args)
    @byr = args.fetch("byr", nil)
    @iyr = args.fetch("iyr", nil)
    @eyr = args.fetch("eyr", nil)
    @hgt = args.fetch("hgt", nil)
    @hcl = args.fetch("hcl", nil)
    @ecl = args.fetch("ecl", nil)
    @pid = args.fetch("pid", nil)
    @cid = args.fetch("cid", nil)
  end

  def valid?
    contains_all_mandatory_fields? &&
    issue_year_valid? &&
    eye_colour_valid? &&
    expiration_year_valid? &&
    passport_id_valid? &&
    hair_colour_valid? &&
    birth_year_valid? &&
    height_valid?
  end

  def contains_all_mandatory_fields?
    @byr && @iyr && @eyr && @hgt && @hcl && @ecl && @pid
  end

  def birth_year_valid?
    @byr.length == 4 && (1920..2002).cover?(@byr.to_i)
  end

  def issue_year_valid?
    @iyr.length == 4 && (2010..2020).cover?(@iyr.to_i)
  end

  def expiration_year_valid?
    @eyr.length == 4 && (2020..2030).cover?(@eyr.to_i)
  end

  def height_valid?
    measure = @hgt.chars.last(2).join
    number = @hgt[0...-2].to_i

    if measure == "cm"
      (150..193).cover?(number)
    elsif measure == "in"
      (59..76).cover?(number)
    else
      false
    end
  end

  def hair_colour_valid?
    @hcl =~ /^#[0-9a-f]{6}$/
  end

  def eye_colour_valid?
    %{amb blu brn gry grn hzl oth}.include? @ecl
  end

  def passport_id_valid?
    @pid =~ /^[0-9]{9}$/
  end
end

class PassportValidator

  REQUIRED_KEYS = %w{iyr ecl eyr pid hcl byr hgt}

  def self.valid?(data_line)
    args = data_line.split.map{|d| d.split(":")}.to_h
    # (REQUIRED_KEYS - args.keys).empty?
    PassPort.new(args).valid?
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

part_two_answer =  PassportLoader.from_data(all_lines).select{ |e| e }.length
# puts "Part 1 answer: #{part_one_results}" # 228
puts "Part 2 answer: #{part_two_answer}" # 178 too high

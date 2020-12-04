require_relative "../file_loader.rb"

class Password

  def initialize(appearance_range, letter, password)
    puts "appearance_range #{appearance_range}, letter #{letter}, password #{password}"
    @appearance_range = appearance_range
    @letter = letter
    @password = password
  end

  def self.from_input(line)
    range, letter, password = line.split(" ")
    range = range.split("-").map(&:to_i)
    new(range[0]..range[1], letter.delete(":"), password)
  end

  def valid?
    @appearance_range.include?(@password.count(@letter))
  end
end

all_passwords = FileLoader.new("./day_2/input.txt").lines(->(x) { Password.from_input(x) })

valid_count = all_passwords.count(&:valid?)
puts "Part 1 answer: #{valid_count}" # 582

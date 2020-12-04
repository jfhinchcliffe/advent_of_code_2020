require_relative "../file_loader.rb"

class Password

  def initialize(appearance_range, letter, password)
    @appearance_range = appearance_range
    @letter = letter
    @password = password
  end

  def self.from_input(line)
    range, letter, password = line.split(" ")
    range = range.split("-").map(&:to_i)
    new(range[0]..range[1], letter.delete(":"), password)
  end

  def part_one_valid?
    @appearance_range.include?(@password.count(@letter))
  end

  def part_two_valid?
    first_letter_location = @appearance_range.first - 1
    second_letter_location = @appearance_range.last - 1

    (
      (@password[second_letter_location] == @letter && @password[first_letter_location] != @letter) ||
      (@password[first_letter_location] == @letter && @password[second_letter_location] != @letter)
    )
  end
end

all_passwords = FileLoader.new("./day_2/input.txt").lines(->(x) { Password.from_input(x) })

puts "Count: #{p2_test.count(&:part_two_valid?)}"
part_one_valid_count = all_passwords.count(&:part_one_valid?)
puts "Part 1 answer: #{part_one_valid_count}" # 582

part_two_valid_count = all_passwords.count(&:part_two_valid?)
puts "Part 2 answer: #{part_two_valid_count}" # 729

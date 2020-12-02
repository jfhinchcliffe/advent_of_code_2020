class FileUtil

  def initialize(filename)
    @filename = filename
  end

  def lines_as_integers
    file.each_line.map(&:to_i)
  end

  private

  def file
    File.open(@filename)
  end
end


lines = FileUtil.new("input.txt").lines_as_integers

# test_lines = [
#   1721,
#   979,
#   366,
#   299,
#   675,
#   1456,
# ]

TARGET_NUMBER = 2020

part_one_result = lines.reduce({}) do |acc, num|
  complement = TARGET_NUMBER - num
  break num * complement if acc[num]

  acc[complement] = num
  acc
end

puts "Part One Result: #{part_one_result}"

# I feel dirty...
lines.each_with_index do |outer_val, outer_index|
  lines.each_with_index do |middle_val, middle_index|
    lines.each_with_index do |inner_val, inner_index|
      if outer_val + middle_val + inner_val == TARGET_NUMBER
        puts "Part Two Result: #{outer_val} * #{middle_val} * #{inner_val} = #{outer_val * middle_val * inner_val}"
        raise
      end
    end
  end
end

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
result = lines.reduce({}) do |acc, num|
  complement = TARGET_NUMBER - num
  if acc[num]
    break num * complement
  else
    acc[complement] = num
  end
  acc
end

puts "Result: #{result}"


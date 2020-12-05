require_relative "../file_loader.rb"



all_lines = FileLoader.new("./day_3/input.txt").lines(->(x) { x.delete("\n") })

test_lines = [
  "..##.......",
  "#...#...#..",
  ".#....#..#.",
  "..#.#...#.#",
  ".#...##..#.",
  "..#.##.....",
  ".#.#.#....#",
  ".#........#",
  "#.##...#...",
  "#...##....#",
  ".#..#...#.#"
]

part_1_results = all_lines.select.with_index do |line, index|
  next if index == 0
  line_array = line.split("")

  line_array.rotate(index * 3).first == "#"
end.count

def solve_slope(lines, right, down)
  lines_done = 0
  lines.select.with_index do |line, index|
    next if index == 0
    next if down == 2 && index % 2 != 0
    lines_done += 1
    line_array = line.split("")

    line_array.rotate(lines_done * right).first == "#"
  end.count
end

# def solve_slope(lines, right, down)
#   loops = lines.length
#   trees = 0
#   line_count = 0
#   until down > loops do
#     line_count += 1
#     line_array = lines[down].split("")
#     trees += 1 if line_array.rotate(line_count * right).first == "#"
#     down += down
#     right = down * right
#   end
#   trees
# end

part_1_results = solve_slope(all_lines, 3, 1)
puts "Part 1 results #{part_1_results}"

part_2_results = solve_slope(all_lines, 1, 1) * solve_slope(all_lines, 3, 1) * solve_slope(all_lines, 5, 1) * solve_slope(all_lines, 7, 1) * solve_slope(all_lines, 1, 2)
puts "Part 2 results #{part_2_results}"
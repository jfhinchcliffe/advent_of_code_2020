require_relative "../file_loader.rb"



all_lines = FileLoader.new("./day_3/input.txt").lines(->(x) { x.delete("\n") })

# all_lines = [
#   "..##.......",
#   "#...#...#..",
#   ".#....#..#.",
#   "..#.#...#.#",
#   ".#...##..#.",
#   "..#.##.....",
#   ".#.#.#....#",
#   ".#........#",
#   "#.##...#...",
#   "#...##....#",
#   ".#..#...#.#"
# ]

results = all_lines.select.with_index do |line, index|
  next if index == 0
  line_array = line.split("")

  line_array.rotate(index * 3).first == "#"
end.count

puts results # 83 not right
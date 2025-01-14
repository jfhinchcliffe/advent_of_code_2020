require_relative "../file_loader.rb"

all_lines = FileLoader.new("./day_6/input.txt").lines(->(x) { x.delete("\n") })

def clean_data(file_lines)
  file_lines.inject([""]) do |acc, line|
    line.empty? ? acc << "" : acc.last << line
    acc
  end
end

pp clean_data(all_lines).sum{|l| l.split("").uniq.length}
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

class FileLoader

  def initialize(filename)
    @filename = filename
  end

  def lines(transform_proc)
    file.each_line.map {|line| transform_proc.call(line) }
  end

  def lines_as_integers
    file.each_line.map(&:to_i)
  end

  private

  def file
    File.open(@filename)
  end
end
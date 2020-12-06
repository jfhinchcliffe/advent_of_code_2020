require_relative "../file_loader.rb"

all_lines = FileLoader.new("./day_5/input.txt").lines(->(x) { x.delete("\n") })

class TicketDecoder

  def self.seat_number(code)
    (process_rows(code[0..6], (0..127).to_a) * 8) + process_seats(code[7..], (0..7).to_a)
  end

  def self.process_seats(remaining_seat_code, remaining_range)
    return remaining_range.first if remaining_range.length == 1

    current_letter = remaining_seat_code[0]
    lower, upper = remaining_range.each_slice(remaining_range.length / 2).to_a

    case current_letter
    when "R"
      process_seats(remaining_seat_code[1..], upper)
    when "L"
      process_seats(remaining_seat_code[1..], lower)
    end
  end

  def self.process_rows(remaining_row_code, remaining_range)
    return remaining_range.first if remaining_range.length == 1

    current_letter = remaining_row_code[0]
    lower, upper = remaining_range.each_slice(remaining_range.length / 2).to_a

    case current_letter
    when "B"
      process_rows(remaining_row_code[1..], upper)
    when "F"
      process_rows(remaining_row_code[1..], lower)
    end
  end
end

puts "Part 1 answer: #{all_lines.map {|ticket_code| TicketDecoder.seat_number(ticket_code) }.max}"
def find_top_crates(crate_structure, instructions, is_reverse_order: false) 
  top_crates = []

  instructions.each do |line|
    formatted_line = line.gsub("\n", "").gsub(" ","")
    instruction_fragments = /move(\d+)from(\d+)to(\d+)/.match(formatted_line)

    total_move = instruction_fragments[1].to_i
    crate_start = instruction_fragments[2].to_i
    crate_end = instruction_fragments[3].to_i

    stack_start = crate_structure[crate_start]
    stack_end = crate_structure[crate_end]

    moving_crates = crate_structure[crate_start].slice((stack_start.length - total_move)..(stack_start.length - 1))

    ordered_moving_crates = is_reverse_order ? moving_crates.reverse! : moving_crates

    crate_structure[crate_start] = crate_structure[crate_start].slice(0..(stack_start.length - (total_move + 1)))
    crate_structure[crate_end] = crate_structure[crate_end].push(ordered_moving_crates).flatten
  end

  top_crates = crate_structure.values.map { |list| list.pop }.flatten.join

  pp top_crates
end

starting_structure = {
  1 => ["B", "Z", "T"],
  2 => ["V", "H", "T", "D", "N"],
  3 => ["B", "F", "M", "D"],
  4 => ["T", "J", "G", "W", "V", "Q", "L"],
  5 => ["W", "D", "G", "P", "V", "F", "Q", "M"],
  6 => ["V", "Z", "Q", "G", "H", "F", "S"],
  7 => ["Z", "S", "N", "R", "L", "T", "C", "W"],
  8 => ["Z", "H", "W", "D", "J", "N", "R", "M"],
  9 => ["M", "Q", "L", "F", "D", "S"]
}
instruction_raw = File.readlines("input.txt")

find_top_crates(starting_structure.dup, instruction_raw, is_reverse_order: true)
find_top_crates(starting_structure.dup, instruction_raw)

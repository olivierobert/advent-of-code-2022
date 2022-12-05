def find_top_crates(crate_structure, instructions, is_reverse_order: false)
  top_crates = []

  instructions.each do |line|
    formatted_line = line.gsub(" ","")
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

def generate_stack_structure_from(stack_data)
  stack_keys = stack_data.pop.split(" ")
  # Replace empty spaces by 0
  stack_crates = stack_data.map { |line| line.gsub("    ", "[0] ").gsub(" ", "").gsub("[", "").split("]") }.reverse
  
  stacks = stack_keys.reduce ({}) do |stack_structure, stack_key|
    stack_structure[stack_key.to_i] = []
    stack_structure
  end

  stack_crates.each do |stack_crate|
    stacks.keys.each do |stack_key|
      crate = stack_crate[stack_key - 1]
      stacks[stack_key] << crate if crate != "0"
    end
  end

  stacks
end

stack_data, instructions = File.read("input.txt").split("\n\n").map { |content| content.split("\n") }

starting_structure = generate_stack_structure_from(stack_data)

find_top_crates(starting_structure.dup, instructions, is_reverse_order: true)
find_top_crates(starting_structure.dup, instructions)

def find_winning_elf_amount(input) 
  elves = []
  elf_index = 0
  
  input.each_line do |line|
    if (line == "\n") 
      elf_index += 1
      next
    end

    if (elves[elf_index].nil?)
      elves[elf_index] = []
    end

    elves[elf_index] << line.to_i
  end

  pp elves.map(&:sum).max
end

file = File.open("input.txt")

find_winning_elf_amount(file)

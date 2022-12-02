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

  # Find amount of calories of the elves who collected the most stars
  pp elves.map(&:sum).max

  # Find amount of calories of the top 3 elves who collected the most stars
  pp elves.map(&:sum).sort_by { |elf| -elf }.slice(0, 3).sum
end

file = File.open("input.txt")

find_winning_elf_amount(file)

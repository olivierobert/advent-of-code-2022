def find_marker(input, pattern_size)
  characters_list = input.chars

  characters_list.each_with_index do |character, index|
    list_to_compare = characters_list.slice((index - (pattern_size - 1))..index)

    if list_to_compare.length == pattern_size && list_to_compare.tally.all? { _2 == 1 }
      pp index + 1
      break
    end
  end
end

content = File.read("input.txt")

find_marker(content, 4)
find_marker(content, 14)

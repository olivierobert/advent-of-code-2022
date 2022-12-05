def find_priorities_sum(input) 
  shared_items = []

  input.each do |line|
    sanitized_line = line.gsub!("\n", "")
    next if sanitized_line.nil?
    dividing_index = sanitized_line.length/2
    
    compartment_one = sanitized_line.slice(0..(dividing_index - 1))
    compartment_two = sanitized_line.slice((dividing_index)..(line.length + 1))

    shared_items << (compartment_one.chars & compartment_two.chars).uniq
  end

  pp compute_priority_sum_for(shared_items)
end

def find_priorities_sum_by_group(input) 
  badges = []

  input.each_slice(3) do |group|
    rucksack_one, rucksack_two, rucksack_three = group.each { |rucksack| rucksack.gsub!("\n", "") }

    badge = rucksack_one.chars & rucksack_two.chars & rucksack_three.chars

    badges << badge
  end

  pp compute_priority_sum_for(badges)
end

def compute_priority_sum_for(list) 
  priority_scores = (('a'..'z').to_a + ('A'..'Z').to_a).map.with_index { |value, index| { value => index + 1 } }

  list.flatten.tally.sort.reduce(0) do |sum, list_item| 
    letter, count = list_item
    priority_score = priority_scores.find { |priority_score| priority_score.keys[0] == letter }.values[0]
  
    sum += priority_score * count
  end
end

content = File.readlines("input.txt")

find_priorities_sum(content)
find_priorities_sum_by_group(content)

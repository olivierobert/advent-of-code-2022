def find_assignment_pair_overlap(input) 
  full_overlap_counter = 0
  partial_overlap_counter = 0

  input.each do |line|
    formatted_line = line.gsub("\n", "")

    assignment_one_range, assignment_two_range = formatted_line.split(",").map do |assignment|
      range_start, range_end = assignment.split("-").map(&:to_i) 
    
      (range_start..range_end)
    end

    if (
      assignment_one_range.cover?(assignment_two_range) || 
      assignment_two_range.cover?(assignment_one_range)
    )
      full_overlap_counter += 1
    end

    if (
      assignment_one_range.to_a.any? { |item| assignment_two_range.include?(item) } || 
      assignment_two_range.to_a.any? { |item| assignment_one_range.include?(item) }
    )
      partial_overlap_counter += 1
    end
  end

  pp full_overlap_counter
  pp partial_overlap_counter
end

content = File.readlines("input.txt")

find_assignment_pair_overlap(content)

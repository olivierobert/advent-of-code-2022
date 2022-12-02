def find_total_point(input) 
  opponent_reference = { "A" => "Rock", "B" => "Paper", "C" => "Scissors" }
  player_reference = { "X" => "Rock", "Y" => "Paper", "Z" => "Scissors" }

  winning_pairs = [["Rock", "Paper"], ["Scissors", "Rock"], ["Paper", "Scissors"]]

  point_rules = { "Rock" => 1, "Paper" => 2, "Scissors" => 3 }
  win_point_amount = 6
  draw_point_amount = 3

  points = 0

  matches = []
  input.each_line do |line|
    match = line.gsub("\n", "").split(" ")
    match[0] = opponent_reference[match[0]]
    match[1] = player_reference[match[1]]

    matches << match
  end
  
  matches.each do |match|
    opponent_hand, player_hand = match
    
    if opponent_hand == player_hand
      points += draw_point_amount + point_rules[player_hand]
    elsif winning_pairs.include?(match)
      points += win_point_amount + point_rules[player_hand]
    else
      points += point_rules[player_hand]
    end
  end

  pp points
end

file = File.open("input.txt")

find_total_point(file)

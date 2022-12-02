def find_total_point(input) 
  opponent_reference = { "A" => "Rock", "B" => "Paper", "C" => "Scissors" }
  outcome_reference = { "X" => :lose, "Y" => :draw, "Z" => :win }

  winning_pairs = [["Rock", "Paper"], ["Scissors", "Rock"], ["Paper", "Scissors"]]

  point_rules = { "Rock" => 1, "Paper" => 2, "Scissors" => 3 }
  win_point_amount = 6
  draw_point_amount = 3

  points = 0

  matches = []
  input.each_line do |line|
    match = []
    combo = line.gsub("\n", "").split(" ")
    opponent_hand = opponent_reference[combo[0]]
    outcome = outcome_reference[combo[1]]

    player_hand = if outcome == :lose
      winning_pairs.find { |pair| pair[1] == opponent_hand }[0]
    elsif outcome == :win
      winning_pairs.find { |pair| pair[0] == opponent_hand }[1]
    else
      opponent_hand
    end
    
    match[0] = opponent_hand
    match[1] = player_hand

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

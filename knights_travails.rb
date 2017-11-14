class Tree
end

class Node
end

class Knight
  move_patterns = [[1, 2], [2, 1], [2, -1], [1, -2],
                  [-1, -2], [-2, -1], [-2, 1], [-1, 2]]

  def legal_move?(from, to)
    # Check if the move goes outside the board
    (from[0] + to[0]).between?(0, 7) && (from[1] + to[1]).between?(0, 7)
  end

  def possible_moves
    
  end

end


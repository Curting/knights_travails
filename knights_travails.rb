class Tile
  attr_accessor :data, :parent, :children

  def initialize(data, parent = nil)
    @data = data
    @parent = parent
    @children = []
  end
end

class Knight
  def initialize(root, target)
    @target = target
    @root = Tile.new(root)
    @tree = [@root]
    @move_patterns = [[1, 2], [2, 1], [2, -1], [1, -2],
                    [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
    @target_node = nil
  end

  def create_children(tile)
    @move_patterns.each do |pattern|
      # If tile is [3, 3] and pattern [1, -2] => [4, 1]
      child = [tile.data[0] + pattern[0], tile.data[1] + pattern[1]]
      if valid_mode?(child)
        child = Tile.new(child, tile)
        # Push all the possible children to the tile for further iteration
        tile.children << child
      end
    end

    tile.children
  end

  def display_path(target_node, path = [])
    if target_node.nil?
      puts "You made it in #{path.length - 1} moves! Here is your path:"
      path.each { |tile| puts tile.to_s }
    else
      path.unshift(target_node.data)
      display_path(target_node.parent, path)
    end
  end

  def valid_mode?(tile)
    tile[0].between?(0, 7) && tile[1].between?(0, 7)
  end

  def bfs(target)
    queue = [@root]

    until queue.empty?
      current = queue.shift
      if current.data == target
        display_path(current)
        break
      else
        create_children(current).each { |child| queue << child }
      end
    end
  end
end

def knight_moves(from, target)
  knight = Knight.new(from, target)
  knight.bfs(target)
end

knight_moves([3,3], [3,2])


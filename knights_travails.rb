class Tile
  attr_accessor :data, :parent, :children

  def initialize(data, parent = nil)
    @data = data
    @parent = parent
    @children = []
  end
end

class Knight
  attr_accessor :root, :visited

  def initialize(root, target)
    @target = target
    @root = Tile.new(root)
    @tree = [@root]
    @visited = [@root]
    @move_patterns = [[1, 2], [2, 1], [2, -1], [1, -2],
                    [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
  end

  def build_tree(tile_ary)
    tile_ary.each do |tile|
      @move_patterns.each do |pattern|
        child = [tile.data[0] + pattern[0], tile.data[1] + pattern[1]]
        tile.children << Tile.new(child, tile) if possible_move?(tile.data, child)
      end
    end
  end

  def inside_board?(from, to)
    # Check if the move goes outside the board
    (from[0] + to[0]).between?(0, 7) && (from[1] + to[1]).between?(0, 7)
  end

  def possible_move?(from, to)
    inside_board?(from, to) && !@visited.include?(to)
  end

  def test
    build_tree(@tree)
  end

  def show_tree
    puts @tree.inspect
  end
end

knight = Knight.new([3,3], [5,7])
knight.show_tree
puts " "
knight.test
knight.show_tree


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
  attr_reader :tree

  def initialize(root, target)
    @target = target
    @root = Tile.new(root)
    @tree = [@root]
    @visited = [@root]
    @move_patterns = [[1, 2], [2, 1], [2, -1], [1, -2],
                    [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
    @target_node = nil
  end

  def build_tree(tile_ary)
    tile_ary.each do |tile|
      target_found = false

      @move_patterns.each do |pattern|
        # If tile is [3, 3] and pattern [1, -2] => [4, 1]
        child = [tile.data[0] + pattern[0], tile.data[1] + pattern[1]]
        if possible_move?(child)
          # Push it to @visited so we won't visit that tile again.
          @visited << child
          target_found = true if child == @target
          child = Tile.new(child, tile)
          # Push all the possible children to the tile for further iteration
          tile.children << child
        end
      end

      # If the target is not found, iterate through all the newly created children
      target_found ? break : build_tree(tile.children)
    end
  end

  def find_path(target_node, path = [])
    if target_node.nil?
      path
    else
      path.unshift(target_node.data)
      find_path(target_node.parent, path)
    end
  end

  def show_path(path_ary)
    puts "You made it in #{path_ary.length} moves! Here is your path:"
    path_ary.each { |tile| puts tile.to_s }
  end

  def inside_board?(tile)
    # Check if the tile is inside the board
    tile[0].between?(0, 7) && tile[1].between?(0, 7)
  end

  def possible_move?(tile)
    inside_board?(tile) && !@visited.include?(tile)
  end

  def breadth_first_search(data, queue = [@root])
    # Queue: Add elements to the back and remove from the front
    current = queue.shift

    if data == current.data
      current
    else
      # Add child to queue from left to right
      current.children.each do |child|
        queue << child unless child.nil?
      end

      # Time for some recursion
      breadth_first_search(data, queue) unless queue.empty?
    end
  end

end

def knight_moves(from, target)
  knight = Knight.new(from, target)
  knight.build_tree(knight.tree)
  target_node = knight.breadth_first_search(target)
  path = knight.find_path(target_node)
  knight.show_path(path)
end

knight_moves([3,3], [4,3])

# Build tree breadth-first until target is found (use queue)
# When target is found assign it (as a node) to a class variable
# Do a parent look-up until nil and use that as the shortest path


class Grid
  def initialize
    @living_neighbors = Hash.new {|h,k| h[k] = 0}
    @cells = {}
  end

  def living_neighbors
    @living_neighbors
  end

  def cells
    @cells
  end

  def add_living_cell(location)
    x, y = location

    x_values = [x-1, x, x+1]
    y_values = [y-1, y, y+1]

    neighbors = x_values.product(y_values)
    neighbors.delete(location)
    neighbors.each {|loc|
      @living_neighbors[loc] += 1
    }

    @cells[location] = 1
  end

  def tick
    new_grid = Grid.new

    living_neighbors.each {|location, count|
      if count == 3
        new_grid.add_living_cell(location)
      end
    }

    cells.each {|location, count|
      if living_neighbors[location] == 2
        new_grid.add_living_cell(location)
      end
    }

    new_grid
  end

  def out
    xn, yn = @cells.keys.transpose
    max_x = xn.max
    max_y = yn.max

    0.upto(max_y) {|y|
        0.upto(max_x) {|x|
        if @cells[[x,y]]
          print "X"
        else
          print " "
        end
      }
      print "\n"
    }
  end
end

class Game
  def initialize
    @grid = Grid.new
    @grid.add_living_cell([3,1])
    @grid.add_living_cell([3,2])
    @grid.add_living_cell([3,3])
    @grid.add_living_cell([2,3])
    @grid.add_living_cell([1,2])
  end

  def start
    i = 0
    loop do
      puts "\e[H\e[2J"
      puts "Iteration: #{i}"
      puts ""
      @grid.out
      @grid = @grid.tick
      i += 1
      sleep 0.1
    end
  end
end

Game.new.start

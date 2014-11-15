require "rspec"

require "grid"

describe Grid do
  let(:grid) {Grid.new}

  it "is empty" do
    expect(grid.living_neighbors).to eq({})
  end

  it "adds a cell and its neighbors" do
    grid.add_living_cell([1,1])

    expect(grid.living_neighbors).to eq({
      [0,0] => 1,
      [0,1] => 1,
      [0,2] => 1,

      [1,0] => 1,
      [1,2] => 1,

      [2,0] => 1,
      [2,1] => 1,
      [2,2] => 1
    })
  end

  it "adds a cell and its neighbors" do
    grid.add_living_cell([1,1])

    expect(grid.cells).to eq({[1,1] => 1})
  end

  it "can tick a still life block" do
    grid.add_living_cell([1,1])
    grid.add_living_cell([1,2])
    grid.add_living_cell([2,1])
    grid.add_living_cell([2,2])

    new_grid = grid.tick

    expect(new_grid.cells).to eq({
      [1,1] => 1,
      [1,2] => 1,
      [2,1] => 1,
      [2,2] => 1
    })
  end

  it "can tick a blinker" do
    grid.add_living_cell([1,1])
    grid.add_living_cell([1,2])
    grid.add_living_cell([1,3])

    new_grid = grid.tick

    expect(new_grid.cells).to eq({
      [0,2] => 1,
      [1,2] => 1,
      [2,2] => 1
    })
  end
end

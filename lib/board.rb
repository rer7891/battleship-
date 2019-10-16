class Board
  attr_reader :cells
  def initialize
    int = 4
    letter = (64 + int).chr.to_s
      cell = []
    ("A"..letter).to_a.each do |x|
    ("1"..int.to_s).to_a.each do |i|
      cell << [x,i].join
    end
    end
        @cells = Hash.new(0)
      cell.map do |x|
        @cells[x] = Cell.new(x)
      end
        @cells
  end

  def valid_coordinate?(coors)
    @cells.key?(coors)
  end

  def validate_placement?(ship, coors)
    return false if !coors.all? { |coor| valid_coordinate?(coor) }
    return false if ship_placed?(coors)

    verify_length(ship, coors) && verify_horizontal(ship, coors) || verify_vertical(coors)
  end

  def verify_length(ship, coors)
    coors.length == ship.length
  end

  def verify_horizontal(ship, coors)
    horizonal_character = coors.map { |x| x[0] }
    vertical_character = coors.map { |x| x[1].to_i }

    (horizonal_character.all? { |char| char == horizonal_character.first}) && (vertical_character.each_cons(2).all? {|a, b| b == a + 1})
  end

  def verify_vertical(coors)
    vertical_letter = coors.map { |x| x[0].ord }
    vertical_number = coors.map { |x| x[1].to_i }

    (vertical_number.all? { |num| num == vertical_number.first}) && (vertical_letter.each_cons(2).all? {|a, b| b == a + 1})
  end

  def ship_placed?(coors)
    coors.any? do |coor|
     @cells[coor].empty == false
    end
  end

  def place(ship, coors)
    coors.map do |coor|
      coor == @cells[coor]
      @cells[coor].place_ship(ship)
    end
  end

  def render(ship_view = false)
    final_board = " "
    letters = @cells.keys.map { |x| x[0] }
    numbers = @cells.keys.map { |x| x[1] }
    final_board += numbers.uniq.join(" ") + "\n"
    letters.uniq.each do |letter|
      final_board += letter
      numbers.uniq.each do |num|
        final_board += " #{@cells[letter + num].render(ship_view)}"
      end
      final_board += "\n"
    end
    print final_board
  end
end

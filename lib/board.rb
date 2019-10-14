class Board
  attr_reader :cells
  def initialize
    @cells = {"A1" => Cell.new("A1"), "A2" => Cell.new("A2"), "A3" => Cell.new("A3"), "A4" => Cell.new("A4"),
              "B1" => Cell.new("B1"), "B2" => Cell.new("B2"), "B3" => Cell.new("B3"), "B4" => Cell.new("B4"),
              "C1" => Cell.new("C1"), "C2" => Cell.new("C2"), "C3" => Cell.new("C3"), "C4" => Cell.new("C4"),
              "D1" => Cell.new("D1"), "D2" => Cell.new("D2"), "D3" => Cell.new("D3"), "D4" => Cell.new("D4")}
  end

  def valid_coordinate?(coors)
    @cells.key?(coors)
  end

  def validate_placement?(ship, coors)
    return false if !coors.all? { |coor| valid_coordinate?(coor) } || ship_placed?(coors)

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

    if ship_view == false
      puts  "  1 2 3 4 \n "
      puts   "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n"
      puts  "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n"
      puts  "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n"
      puts  "D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render}"
    elsif ship_view == true
      puts  "  1 2 3 4 \n "
      puts   "A #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)} \n"
      puts  "B #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)} \n"
      puts  "C #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)} \n"
      puts  "D #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)}"
    end

   "\s 1 2 3 4 \n A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render}\n +
    B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n +
    C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n +
    D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render}"
  end

end

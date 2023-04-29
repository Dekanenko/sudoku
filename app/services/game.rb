# frozen_string_literal: true

class Game

  def self.initialize
    deck = [[0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0]]
    return deck
  end

  def self.auto_generation
    deck = initialize

    cells_to_fill = (81 * 0.3).round
    cells_to_fill.times do
      i, j = rand(9), rand(9)
      while deck[i][j] != 0
        i, j = rand(9), rand(9)
      end

      num = rand(1..9)
      while !check_position(deck, i, j, num)
        num = rand(1..9)
      end
      deck[i][j] = num
    end
    return deck
  end

  def self.check_position(deck, i, j, num)

    # check row
    for inner_i in (0..deck.size - 1)
      if(inner_i == i)
        next
      end

      if(deck[inner_i][j] == num)
        return false
      end
    end

    #  check column
    for inner_j in (0..deck.size - 1)
      if(inner_j == j)
        next
      end

      if(deck[i][inner_j] == num)
        return false
      end
    end

    # check square
    square_i = 3*(i/3)
    square_j = 3*(j/3)
    for inner_i in (square_i..square_i+2)
      for inner_j in (square_j..square_j+2)
        if(inner_i == i && inner_j == j)
          next
        end
        if(deck[inner_i][inner_j] == num)
          return false
        end
      end
    end

    return true
  end

  def self.auto_fill(deck)
    auto_fill_sudoku(deck, 0, 0)

    return deck
  end

    def self.auto_fill_sudoku(sudoku, row=0, col=0)
      return true if row == sudoku.length - 1 && col == sudoku.length # базовый случай: достигнут конец судоку

      if col == sudoku.length # переход на следующую строку, если достигнут конец текущей строки
        row += 1
        col = 0
      end

      if sudoku[row][col] != 0 # ячейка не пустая, пропускаем
        return auto_fill_sudoku(sudoku, row, col + 1)
      end

      # пробуем заполнить ячейку числом от 1 до 9
      (1..9).each do |num|
        if check_position(sudoku, row, col, num)
          sudoku[row][col] = num # вставляем число в ячейку
          if auto_fill_sudoku(sudoku, row, col + 1)
            return true # если удалось рекурсивно заполнить судоку, то возвращаем true
          end
          sudoku[row][col] = 0 # откатываем изменения, если заполнение было неудачным
        end
      end

      return false # если не удалось найти корректное число для заполнения текущей ячейки, то возвращаем false
    end

  def self.check_deck(deck)
    tmp = check_rows(deck)
    if(tmp != -1)
      return "Incorrect fulfilment in row : #{tmp}"
    end

    tmp = check_columns(deck)
    if(tmp != -1)
      return "Incorrect fulfilment in column : #{tmp}"
    end

    tmp = check_squares(deck)
    if(tmp != "")
      return "Incorrect fulfilment in square : #{tmp}"
    end

    if(!check_complete(deck))
      return "Fulfilment is correct, but the game is not finished yet"
    else
      return "WIN!!! Congratulations!!!"
    end

  end

  def self.print_deck(deck)
    for i in (0..deck.size-1)
      for j in (0..deck.size-1)
        print(deck[i][j], "  ")
      end
      puts()
    end
  end

  private

  def self.check_rows(deck)
    for i in (0..deck.size-1)
      set = Set.new
      for j in (0..deck.size-1)
        if(set.include?(deck[i][j]) && deck[i][j] != 0)
          return i
        end
        set << deck[i][j]
      end
    end

    return -1
  end

  def self.check_columns(deck)
    for j in (0..deck.size-1)
      set = Set.new
      for i in (0..deck.size-1)
        if(set.include?(deck[i][j]) && deck[i][j] != 0)
          return j
        end
        set << deck[i][j]
      end
    end

    return -1
  end

  def self.check_squares(deck)
    for i in (0..deck.size-3).step(3)
      for j in (0..deck.size-3).step(3)
        set = Set.new
        for inner_i in (i..i+2)
          for inner_j in (j..j+2)
            if(set.include?(deck[inner_i][inner_j]) && deck[inner_i][inner_j] != 0)
              return "(#{i/3} ; #{j/3})"
            end
            set << deck[inner_i][inner_j]
          end
        end
      end
    end
    return ""
  end

  def self.check_complete(deck)
    for i in (0..deck.size-1)
      for j in (0..deck.size-1)
        if(deck[i][j] == 0)
          return false
        end
      end
    end
    return true
  end

    def self.check_position(deck, i, j, num)

      # check row
      for inner_i in (0..deck.size - 1)
        if(inner_i == i)
          next
        end

        if(deck[inner_i][j] == num)
          return false
        end
      end

      #  check column
      for inner_j in (0..deck.size - 1)
        if(inner_j == j)
          next
        end

        if(deck[i][inner_j] == num)
          return false
        end
      end

      # check square
      square_i = 3*(i/3)
      square_j = 3*(j/3)
      for inner_i in (square_i..square_i+2)
        for inner_j in (square_j..square_j+2)
          if(inner_i == i && inner_j == j)
            next
          end
          if(deck[inner_i][inner_j] == num)
            return false
          end
        end
      end

      return true
    end

end

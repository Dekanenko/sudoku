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

    # add code for auto generation

    return deck
  end

  def self.auto_fill(deck)

    # add code for adding right numbers

    return deck
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

end

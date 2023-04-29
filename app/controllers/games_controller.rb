# frozen_string_literal: true

class GamesController < ApplicationController

  def index
    @deck = Game.initialize
  end


  def manual_fill
    @deck = parse_deck(params[:deck])
    if(@deck.nil?)
      flash.alert = "INCORRECT INPUT!!! NUMBERS ONLY (1-9)!!!"
      redirect_to root_path
      return
    end

    message = Game.check_deck(@deck)
    flash.notice = message

    render "games/index"
  end

  def auto_fill
    @deck = parse_deck(params[:deck])
    if(@deck.nil?)
      flash.alert = "INCORRECT INPUT!!! NUMBERS ONLY (1-9)!!!"
      redirect_to root_path
      return
    end

    @deck = Game.auto_fill(@deck)
    render "games/index"
  end

  def auto_generation
    @deck = Game.auto_generation
    render "games/index"
  end

  private

  def parse_deck(str)
    deck = Game.initialize
    rows = str.split('|')
    i = 0
    begin
      rows.each do |row|
        j = 0
        elements = row.split(',')
        elements.each do|elem|
          deck[i][j] = Integer(elem)
          if(deck[i][j] < 0 || deck[i][j] > 9)
            return nil
          end
          j += 1
        end
        i += 1
      end
    rescue ArgumentError
      return nil
    end
    return deck
  end


end

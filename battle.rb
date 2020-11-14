require_relative "player"
require_relative "pokedex"

class Battle
  include Pokedex

  attr_reader :winner_pokemon

  def initialize(player1, bot)
    @player1 = player1
    @bot = bot
    @pokemon1 = @player1.pokemon
    @pokemon2 = @bot.pokemon
    @winner_pokemon = nil
  end

  def start
    @pokemon1.prepare_for_battle
    @pokemon2.prepare_for_battle

    puts "#{@bot.name} sent out #{@pokemon2.name}!"
    puts "#{@player1.name} sent out #{@pokemon1.name}!"
    puts "-------------------Battle Start!-------------------\n\n"
    until @pokemon1.fainted? || @pokemon2.fainted?
      puts "#{@player1.name}'s #{@pokemon1.name} - Level #{@pokemon1.level}"
      puts "HP: #{@pokemon1.hp}"
      puts "#{@bot.name}'s #{@pokemon2.name} - Level #{@pokemon2.level}"
      puts "HP: #{@pokemon2.hp}\n\n"
      puts "#{@player1.name}, select your move:\n\n"
      move1 = @player1.select_move
      move2 = @bot.select_move
      @pokemon1.set_current_move(move1)
      @pokemon2.set_current_move(move2)
      first = attack_order(@pokemon1, @pokemon2)
      second = first == @pokemon1 ? @pokemon2 : @pokemon1
      puts "\n--------------------------------------------------"
      first.attack(second)
      puts "\n--------------------------------------------------"
      second.attack(first) unless second.fainted?
      puts "\n--------------------------------------------------"
      next unless first.fainted?
    end
    @winner = @pokemon1.fainted? ? @pokemon2 : @pokemon1
    @loser = @winner == @pokemon1 ? @pokemon2 : @pokemon1
    @winner_pokemon = @winner
    puts "#{@loser.name} FAINTED!"
    puts "\n--------------------------------------------------"
    puts "#{@winner.name} WINS!"
    if @winner == @pokemon1
      @winner.increase_stats(@pokemon2)
    end
    puts "\n-------------------Battle Ended!-------------------"
  end

  def attack_order(pokemon1, pokemon2)
    priority1 = MOVES[pokemon1.current_move][:priority]
    priority2 = MOVES[pokemon2.current_move][:priority]
    if priority1 != priority2
      compare = priority1 <=> priority2
    else
      compare = pokemon1.stats[:speed] <=> pokemon2.stats[:speed]
    end
    case compare
    when -1 then pokemon2
    when 1 then pokemon1
    when 0 then [pokemon1, pokemon2].sample
    end
  end
end

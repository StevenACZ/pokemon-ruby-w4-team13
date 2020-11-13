require_relative "player"
require_relative "pokedex"

class Battle
  include Pokedex

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @pokemon1 = @player1.pokemon
    @pokemon2 = @player2.pokemon

    p @pokemon1
    puts
    p @pokemon2
  end

  def start
    @pokemon1.prepare_for_battle
    @pokemon2.prepare_for_battle

    puts "#{@player2.name} sent out #{@pokemon2.name}!"
    puts "#{@player1.name} sent out #{@pokemon1.name}!"
    puts "-------------------Battle Start!-------------------\n\n"
    until @pokemon1.fainted? || @pokemon2.fainted?
      puts "#{@player1.name}'s #{@pokemon1.name} - Level #{@pokemon1.level}"
      puts "HP: #{@pokemon1.hp}"
      puts "#{@player2.name}'s #{@pokemon2.name} - Level #{@pokemon2.level}"
      puts "HP: #{@pokemon2.hp}\n\n"
      puts "#{@player1.name}, select your move:\n\n"
      @player1.select_move
      puts "\n--------------------------------------------------"
    end

    # Prepare the Battle (print messages and prepare pokemons)

    # Until one pokemon faints
    # --Print Battle Status
    # --Both players select their moves

    # --Calculate which go first and which second

    # --First attack second
    # --If second is fainted, print fainted message
    # --If second not fainted, second attack first
    # --If first is fainted, print fainted message

    # Check which player won and print messages
    # If the winner is the Player increase pokemon stats
  end
end

# player1 = Player.new("Steven", "Bulbasaur", "CapiGrass")

# bot = Bot.new("Bulbasaur", rand(6))

# battle = Battle.new(player1, bot)
# battle.start
require_relative "player"
require_relative "battle"
require_relative "pokedex"
require "colorize"

class Game
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Layout/LineLength
  def welcome
    puts "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#
#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#
#$##$##$##$##{c('---', :blue)}       Pokemon Ruby         #{c('---', :blue)}#$##$##$#$#$#
#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#
#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#\n
Hello there#{c('!', :blue)} Welcome to the world #{c('of', :magenta)} #{c('POKEMON', :light_yellow)}#{c('!', :blue)} My name is OAK#{c('!', :blue)}
People call me the #{c('POKEMON PROF', :light_yellow)}#{c('!', :blue)}\n
This world is inhabited by creatures called #{c('POKEMON', :light_yellow)}#{c('!', :blue)} For some
people, #{c('POKEMON', :light_yellow)} are pets. Others use them #{c('for', :magenta)} fights. Myself#{c('...', :blue)}
I study #{c('POKEMON', :light_yellow)} #{c('as', :magenta)} a profession.
First, what is your name#{c('?', :blue)}"
    name = "Andre" # gets.chomp
    puts "\nRight#{c('!', :blue)} So your name is #{c(name.capitalize, :light_yellow)}#{c('!', :blue)}
Your very own #{c('POKEMON', :light_yellow)} legend is about to unfold#{c('!', :blue)} #{c('A', :light_yellow)} world #{c('of', :magenta)}
dreams and adventures #{c('with', :magenta)}  #{c('POKEMON', :light_yellow)} awaits#{c('!', :blue)} Let's go#{c('!', :blue)}
Here, #{name.capitalize} There are #{c('3', :green)}   #{c('POKEMON', :light_yellow)} here! Haha!
When #{c('I', :blue)} was young, #{c('I', :blue)} was a serious  #{c('POKEMON', :light_yellow)} trainer.
In my old age, #{c('I', :blue)} have only #{c('3', :green)}  left, but you can have one#{c('!', :blue)} Choose#{c('!', :blue)}\n\n"
    puts "#{c('1.', :green)}Bulbasaur    #{c('2.', :green)}Charmander   #{c('3.', :green)}Squirtle\n"
    pokemon = "Charmander" # gets.c"homp.downcase
    # until check_initial_pokemon(pokemon)
    #   puts "#{c('1.', :green)}Bulbasaur    #{c('2.', :green)}Charmander   #{c('3.', :green)}Squirtle\n"
    #   pokemon = gets.chomp.downcase
    # end
    puts "You selected #{c(pokemon.upcase, :light_yellow)}. Great choice#{c('!', :blue)}
Give your pokemon a name#{c('?', :blue)}"
    pokemon_name = "Char" # gets.chomp
    pokemon_name = pokemon_name == "" ? pokemon : pokemon_name
    puts "#{c(name.upcase, :light_yellow)}, raise your young #{c(pokemon_name.upcase, :light_yellow)} by making it fight#{c('!', :blue)}
When you feel ready you can challenge #{c('BROCK', :light_yellow)}, the #{c('PEWTER', :light_yellow)}'s #{c('GYM LEADER', :light_yellow)}"
    [name, pokemon, pokemon_name]
  end
  # rubocop:enable Metrics/AbcSize, Layout/LineLength

  def start
    player = welcome
    @player = Player.new(player[0], player[1], player[2])
    @pokemon = @player.pokemon
    # Then create a Player with that information and store it in @player
    # @player = Player.new(player[0], player[1], player[2])
    action = menu
    until action == "exit"
      case action
      when "train"
        train
        action = menu
      when "leader"
        challenge_leader
        action = menu
      when "stats"
        show_stats
        action = menu
      end
    end
    goodbye
  end
  # rubocop:enable Metrics/MethodLength,

  def train
    # Compelte this
    puts "Tu entrenamiento comienza"
  end

  def challenge_leader
    # Compelte this
    puts "Ha llegado el momento"
  end

  def show_stats
    p @pokemon
    puts "#{@pokemon.name}:"
    puts "Kind: #{@pokemon.specie}"
    puts "Level: #{@pokemon.level}"
    puts "Type: " + @pokemon.type.join("")
    puts "Stats:"
    puts "HP: #{@pokemon.stats[:hp]}"
    puts "Attack: #{@pokemon.stats[:attack]}"
    puts "Defense: #{@pokemon.stats[:defense]}"
    puts "Special Attack: #{@pokemon.stats[:special_attack]}"
    puts "Special Defense: #{@pokemon.stats[:special_defense]}"
    puts "Speed: #{@pokemon.stats[:speed]}"
    puts "Experience Points: #{@pokemon.base_exp}"

  end

  def goodbye
    puts puts "\nThanks #{c('for', :magenta)} playing  #{c('POKEMON RUBY', :light_yellow)}"
    print "This game was created #{c('with', :magenta)} love by #{c('for', :magenta)}"
    print "[:#{c('Androre', :light_blue)}, :#{c('Steven', :light_blue)}, :#{c('JuanCarlos', :light_blue)}]"
  end

  def menu
    puts "#{c('--------------------------', :blue)}Menu#{c('--------------------------', :blue)}\n"
    print "#{c('1.', :green)}Stats        #{c('2.', :green)}Train        #{c('3.', :green)}"
    print "Leader       #{c('4.', :green)}Exit"
    puts
    print "Action: "
    # comandos = %w[stats train leader exit]
    # action_input = gets.chomp.downcase
    # p action_input
    # until comandos.any? { |action| action == action_input }
    # puts "Action error: "
    # action_input = gets.chomp.downcase
    # end
    gets.chomp.downcase
  end

  private

  def c(str, color)
    str.colorize(color)
  end

  def check_initial_pokemon(pokemon)
    list_pokemon = %w[bulbasaur charmander squirtle]
    list_pokemon.any? { |pokemon_name| pokemon_name == pokemon }
  end
end
def c(str, color)
  str.colorize(color)
end
game = Game.new
game.start

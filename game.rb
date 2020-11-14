require_relative "player"
require_relative "battle"
require_relative "pokedex"
require "colorize"

class Game
  include Pokedex

  def initialize
    @player_name = nil
    @specie = nil
    @pokemon_name = nil
  end

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
    @player_name = gets.chomp # PLAYER 
    puts "\nRight#{c('!', :blue)} So your name is #{c(@player_name.capitalize, :light_yellow)}#{c('!', :blue)}
Your very own #{c('POKEMON', :light_yellow)} legend is about to unfold#{c('!', :blue)} #{c('A', :light_yellow)} world #{c('of', :magenta)}
dreams and adventures #{c('with', :magenta)} #{c('POKEMON', :light_yellow)} awaits#{c('!', :blue)} Let's go#{c('!', :blue)}
Here, #{@player_name.capitalize}! There are #{c('3', :green)} #{c('POKEMON', :light_yellow)} here! Haha!
When #{c('I', :blue)} was young, #{c('I', :blue)} was a serious  #{c('POKEMON', :light_yellow)} trainer.
In my old age, #{c('I', :blue)} have only #{c('3', :green)}  left, but you can have one#{c('!', :blue)} Choose#{c('!', :blue)}\n\n"
    puts "#{c('1.', :green)}Bulbasaur    #{c('2.', :green)}Charmander   #{c('3.', :green)}Squirtle\n"
    @specie = gets.chomp.capitalize # POKEMON
    until check_initial_pokemon(@specie)
      puts "#{c('1.', :green)}Bulbasaur    #{c('2.', :green)}Charmander   #{c('3.', :green)}Squirtle\n"
      @specie = gets.chomp.capitalize
    end
    puts "\nYou selected #{c(@specie.upcase, :light_yellow)}. Great choice#{c('!', :blue)}
Give your pokemon a name#{c('?', :blue)}"
    @pokemon_name = gets.chomp # POKEMON NAME
    @pokemon_name = @pokemon_name == "" ? @specie : @pokemon_name
    puts "\n#{c(@player_name.upcase, :light_yellow)}, raise your young #{c(@pokemon_name.upcase, :light_yellow)} by making it fight#{c('!', :blue)}
When you feel ready you can challenge #{c('BROCK', :light_yellow)}, the #{c('PEWTER', :light_yellow)}'s #{c('GYM LEADER', :light_yellow)}"
  end
  # rubocop:enable Metrics/AbcSize, Layout/LineLength

  def start
    welcome
    @player = Player.new(@player_name, @specie, @pokemon_name)
    action = menu
    until action == "exit"
      case action
      when "stats"
        show_stats
        action = menu
      when "train"
        train
        action = menu
      when "leader"
        challenge_leader
        action = menu
      end
    end
    goodbye
  end
  # rubocop:enable Metrics/MethodLength,

  def train
    puts "Tu entrenamiento comienza"
    random_pokemon = POKEMONS.keys.sample
    bot = Bot.new(random_pokemon, rand(1..5))
    puts "#{@player.name} challenge #{bot.name} for training"
    puts "#{bot.name} has a #{bot.pokemon.name} level #{bot.pokemon.level}"
    decition = show_decition
    if decition == "Leave"
      return true
    elsif decition == "Fight"
      battle = Battle.new(@player, bot)
      battle.start
    end
  end

  def challenge_leader
    puts "Ha llegado el momento"
    puts "#{@player.name} challenge the Gym Leader Brock for a fight!"
    puts "Brock has a Onix level 10"
    decition = show_decition
    if decition == "Leave"
      return true
    elsif decition == "Fight"
      brock = Bot.new("Onix", 10)
      battle = Battle.new(@player, brock)
      battle.start
    end
    if battle.winner_pokemon == @player.pokemon
      puts "Congratulation! You have won the game!"
      puts "You can continue training your Pokemon if you want"
    end
  end

  def show_stats
    puts "#{@player.pokemon.name}:"
    puts "Kind: #{@player.pokemon.specie}"
    puts "Level: #{@player.pokemon.level}"
    puts "Type: " + @player.pokemon.type.join(" ")
    puts "Stats:"
    puts "HP: #{@player.pokemon.stats[:hp]}"
    puts "Attack: #{@player.pokemon.stats[:attack]}"
    puts "Defense: #{@player.pokemon.stats[:defense]}"
    puts "Special Attack: #{@player.pokemon.stats[:special_attack]}"
    puts "Special Defense: #{@player.pokemon.stats[:special_defense]}"
    puts "Speed: #{@player.pokemon.stats[:speed]}"
    puts "Experience Points: #{@player.pokemon.experience_points}"
  end

  def goodbye
    puts "\nThanks #{c('for', :magenta)} playing  #{c('POKEMON RUBY', :light_yellow)}"
    print "This game was created #{c('with', :magenta)} love by #{c('for', :magenta)}"
    print "[:#{c('Androre', :light_blue)}, :#{c('Steven', :light_blue)}, :#{c('JuanCarlos', :light_blue)}]\n\n"
  end

  def menu
    puts "#{c('--------------------------', :blue)}Menu#{c('--------------------------', :blue)}\n"
    print "#{c('1.', :green)}Stats        #{c('2.', :green)}Train        #{c('3.', :green)}"
    print "Leader       #{c('4.', :green)}Exit"
    puts
    print "Action: "
    gets.chomp.downcase
  end

  private

  def c(str, color)
    str.colorize(color)
  end

  def check_initial_pokemon(pokemon)
    list_pokemon = %w[Bulbasaur Charmander Squirtle]
    list_pokemon.any? { |pokemon_name| pokemon_name == pokemon }
  end

  def show_decition
    puts "What do you want to do now?"
    puts "\n1. Fight        2. Leave"
    decition = gets.chomp.capitalize
    until decition == "Leave" || decition == "Fight"
      puts "\n1. Fight        2. Leave"
      decition = gets.chomp.capitalize
    end
    decition
  end
end

game = Game.new
game.start

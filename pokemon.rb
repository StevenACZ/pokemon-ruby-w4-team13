require_relative "pokedex"
# rubocopsable all
class Pokemon
  include Pokedex

  def initialize(specie, level, name = nil)
    # Retrieve pokemon info from Pokedex and set instance variables
    # Calculate Individual Values and store them in instance variable
    # Create instance variable with effort values. All set to 0
    # Store the level in instance variable
    # If level is 1, set experience points to 0 in instance variable.
    # If level is not 1, calculate the minimum experience point for that level and store it in instance variable.
    # Calculate pokemon stats and store them in instance variable
    initialize_pokedex_variables(specie)
    @name = name || POKEMONS[specie][:species]
    @level = level
    @individual_stats = { hp: rand(32), attack: rand(32), defense: rand(32), special_attack: rand(32), special_defense: rand(32), speed: rand(32) }
    @effort_values = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 } #variable
    initialize_experience_points(@level)
    @stats = { hp: calculate_hp, attack: calculate_else("attack"), defense: calculate_else("defense"), special_attack: calculate_else("special_attack"), special_defense: calculate_else("special_defense"), speed: calculate_else("speed") }
  end

  def initialize_pokedex_variables(specie)
    pokemon_specie = POKEMONS[specie]
    @specie = pokemon_specie[:species]
    @type = pokemon_specie[:type]
    @base_exp = pokemon_specie[:base_exp]
    @growth_rate = pokemon_specie[:growth_rate]
    @base_stats = pokemon_specie[:base_stats]
    @effort_points = pokemon_specie[:effort_points]
    @moves = pokemon_specie[:moves]
  end

  def initialize_experience_points(level)
    if(level == 1)
      @experience_points = 0
    elsif level != 1 && @growth_rate == slow
      @experience_points = (5 / 4.0 * @level**3).floor
    elsif level != 1 && @growth_rate == medium_slow
      @experience_points = (6 / 5.0 * @level**3 - 15 * @level**2 + 100 * @level -140).floor
    elsif level != 1 && @growth_rate == medium_fast
      @experience_points = @level**3
    elsif level != 1 && @growth_rate == fast
      @experience_points = (4 / 5.0 * @level**3).floor
    end
  end

  def calculate_hp
    stat_effort = (@effort_values[:hp] / 4.0).floor
    ((2 * @base_stats[:hp] + @individual_stats[:hp] + stat_effort) * @level / 100 + @level + 10).floor  
  end

  def calculate_else(stat)
    stat_effort = (@effort_values[stat.to_sym] / 4.0).floor
    ((2 * @base_stats[stat.to_sym] + @individual_stats[stat.to_sym] + stat_effort) * @level / 100 + 5).floor
  end

  def prepare_for_battle
    @hp = @stats[:hp]
    @current_move = nil
  end

  def receive_damage
    # Complete this
  end

  def set_current_move(name_player, move_player)
    # No se si debo buscar y devolver el hash completo o solo setear el valoe dentor de current_move
=begin
    puts "#{name_player.upcase}, select your move:"
    count = 0
    @moves.each { |move| print " #{count += 1}. #{move} \t\t" }
    puts ""
    current_move = gets.chomp.downcase
    MOVES.each do |k|
      current_move = k[1] if k[0] == current_move
    end
    p current_move
=end
    @current_move = move_player
  end

  def fainted?
    # Complete this
    !@hp.positive?
  end


  def attack(target)
    puts "#{@name} used #{@current_move.upcase}!"
    # Accuracy check
    if accuracy_check(@current_move) # If the movement is not missed
      #  (1) Calculate base damage
      damage = base_damage(target)
      # (2) Critical Hit check

      # -- If critical, multiply base damage and print message 'It was CRITICAL hit!'
      # (3) Type Effectiveness
      # -- Effectiveness check
      # -- Mutltiply damage by effectiveness multiplier and round down. Print message if neccesary
      # ---- "It's not very effective..." when effectivenes is less than or equal to 0.5
      # ---- "It's super effective!" when effectivenes is greater than or equal to 1.5
      # ---- "It doesn't affect [target name]!" when effectivenes is 0


      # -- Inflict damage to target and print message "And it hit [target name] with [damage] damage""
    else
      puts "But it MISSED!"
    end
  end

  def accuracy_check(move)
    result = rand(0..100)
    return (0..MOVES[move][:accuracy]).to_a.include?(result) || false
  end

  def base_damage(target)
     is_special = SPECIAL_MOVE_TYPE.include?(MOVES[@current_move][:type].to_s) || false
     move_power = MOVES[@current_move][:power]
     if is_special
      offensive_stat = @stats[:special_attack]
      defensive_stat = target.stats[:special_defense]
     else
      offensive_stat = @stats[:attack]
      defensive_stat = target.stats[:defense]
     end
     damage = (((2 * @level / 5.0 + 2).floor * offensive_stat * move_power / defensive_stat).floor / 50.0).floor + 2
  end

  def critical_hit_check
    return rand(1..16) == 7 || false
  end

  def increase_stats(target)
    # Increase stats base on the defeated pokemon and print message "#[pokemon name] gained [amount] experience points"

    # If the new experience point are enough to level up, do it and print message "#[pokemon name] reached level [level]!"
    # -- Re-calculate the stat
  end

  # private methods:
  # Create here auxiliary methods
end

prueba = Pokemon.new("Pikachu", 1)
p prueba
puts prueba.accuracy_check("rock throw")
prueba.set_current_move("carlos", "thunder shock")

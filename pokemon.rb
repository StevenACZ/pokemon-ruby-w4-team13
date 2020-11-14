require_relative "pokedex"

class Pokemon
  include Pokedex

  attr_accessor :set_current_move, :current_move
  attr_reader :specie, :type, :base_exp, :growth_rate, :base_stats, :effort_points, :moves, :stats, :name, :level, :hp, :set_current_move, :current_move, :experience_points

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
    @experience_points = initialize_experience_points(@level)
    @stats = { hp: calculate_hp, attack: calculate_else("attack"), defense: calculate_else("defense"), special_attack: calculate_else("special_attack"), special_defense: calculate_else("special_defense"), speed: calculate_else("speed") }
    @current_move = nil
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
    if level == 1
      return 0
    elsif level != 1 && @growth_rate == :slow
      return (5 / 4.0 * level**3).floor
    elsif level != 1 && @growth_rate == :medium_slow
      return (6 / 5.0 * level**3 - 15 * level**2 + 100 * level -140).floor
    elsif level != 1 && @growth_rate == :medium_fast
      return @level**3
    elsif level != 1 && @growth_rate == :fast
      return (4 / 5.0 * level**3).floor
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

  def receive_damage(damage)
    @hp -= damage
  end

  def set_current_move(move_player)
    @current_move = move_player
  end

  def fainted?
    !@hp.positive?
  end


  def attack(target)
    puts "#{@name} used #{@current_move.upcase}!"
    if accuracy_check(@current_move)
      # (1) Calculate base damage
      damage = base_damage(target)
      # (2) Critical Hit check
      if critical_hit_check
        damage *= 1.5
        puts "It was CRITICAL hit!"
      end
      # (3) Type Effectiveness
      effectiveness = calculate_effectiveness_multiplier(target)
      damage *= effectiveness
      damage = damage.floor
      puts "It's not very effective..." if effectiveness <= 0.5
      puts "It's super effective!" if effectiveness >= 1.5
      puts "It doesn't affect #{target.name}!" if effectiveness == 0
      target.receive_damage(damage)
      puts "And it hit #{target.name} with #{damage} damage"
    else
      puts "But it MISSED!"
    end
  end

  def accuracy_check(move)
    result = rand(0..100)
    return (0..MOVES[move][:accuracy]).to_a.include?(result) || false
  end

  def base_damage(target)
     is_special = SPECIAL_MOVE_TYPE.include?(MOVES[@current_move][:type].to_sym) || false
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

  def calculate_effectiveness_multiplier(target)
    multiplier = 1
    rounds = target.type.size
    rounds.times do |round|
      hash = TYPE_MULTIPLIER.find do |pair|
        pair[:user] == MOVES[@current_move][:type] && pair[:target] == target.type[round-1]
      end
      multiplier *= hash[:multiplier] unless hash == nil
    end
    multiplier
  end

  def increase_stats(target)
    @effort_values[target.effort_points[:type]] += target.effort_points[:amount]
    experience_points_earned = (target.base_exp * target.level / 7.0).floor
    puts "#{@name} gained #{experience_points_earned} experience points"
    next_level = initialize_experience_points(@level + 1)
    @experience_points += experience_points_earned
    while @experience_points >= next_level
      @level += 1
      puts "#{@name} grew to level #{@level}!"
      @stats = { hp: calculate_hp, attack: calculate_else("attack"), defense: calculate_else("defense"), special_attack: calculate_else("special_attack"), special_defense: calculate_else("special_defense"), speed: calculate_else("speed") }
      next_level = initialize_experience_points(@level + 1)
    end
  end

  # private methods:
  # Create here auxiliary methods
end

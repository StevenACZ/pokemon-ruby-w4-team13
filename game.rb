require_relative "player"
require_relative "battle"
require_relative "pokedex"

class Game
  def start
    # Create a welcome method(s) to get the name, pokemon and pokemon_name from the user

    # Then create a Player with that information and store it in @player

    # Suggested game flow
    action = menu
    until action == "Exit"
      case action
      when "Train"
        train
        action = menu
      when "Leader"
        challenge_leader
        action = menu
      when "Stats"
        show_stats
        action = menu
      end
    end

    goodbye
  end

  def train
    # Compelte this
  end

  def challenge_leader
    # Compelte this
  end

  def show_stats
    # Compelte this
  end

  def goodbye
    # Compelte this
  end

  def menu; end
end

game = Game.new
game.start

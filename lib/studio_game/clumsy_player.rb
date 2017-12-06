require_relative 'player'

module StudioGame
  class ClumsyPlayer < Player
    attr_reader :w00t_factor

    def initialize(name, health=100, w00t_factor)
      super(name, health)
      @w00t_factor = w00t_factor
    end

    def found_treasure(treasure)
      damaged_treasure = Treasure.new(treasure.name, treasure.points / 2)
      super(damaged_treasure)
    end

    def w00t
      @health += 15 * @w00t_factor
      puts "#{@name} got w00ted for a value of #{15 * @w00t_factor}"
    end
  end
end

if __FILE__ == $0
  clumsy = ClumsyPlayer.new("klutz")

  hammer = Treasure.new(:hammer, 50)
  clumsy.found_treasure(hammer)
  clumsy.found_treasure(hammer)
  clumsy.found_treasure(hammer)

  crowbar = Treasure.new(:crowbar, 400)
  clumsy.found_treasure(crowbar)

  clumsy.each_found_treasure do |treasure|
    puts "#{treasure.points} total #{treasure.name} points"
  end
  puts "#{clumsy.points} grand total points"
end
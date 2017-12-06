require_relative 'die'
require_relative 'loaded_die'
require_relative 'treasure_trove'

module StudioGame
  module GameTurn
    def self.take_turn(player)
      case Die.new.roll
      when 5..6
        player.w00t
      when 3..4
        puts "#{player.name} got passed"
      else
        player.blam
      end
      treasure = TreasureTrove.random
      player.found_treasure(treasure)
      puts player
    end
  end
end
require_relative 'player'

module StudioGame
  class BerserkPlayer < Player

    def initialize(name, health=100)
      super(name, health)
      @w00tCount = 0;
    end

    def berserk?
      @w00tCount > 5
    end

    def w00t
      super()
      @w00tCount += 1
      puts "#{@name} player is Berserk!" if berserk?
    end
    def blam
      berserk? ? w00t : super
    end
  end
end



if __FILE__ == $0
  berserker = BerserkPlayer.new("berserker", 50)
  6.times { berserker.w00t }
  2.times { berserker.blam }
  puts berserker.health
end

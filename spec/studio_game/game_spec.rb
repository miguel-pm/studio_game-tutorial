require 'studio_game/game'
require 'studio_game/player'
require 'studio_game/die'

module StudioGame
  describe Game do

    before do
      $stdout = StringIO.new
      @game = Game.new("Knuckleheads")
      @initial_health = 100
      @player = Player.new("moe", @initial_health)
      @game.add_player(@player)
    end

    it "should w00t the player with a die roll of 5 or 6" do
      allow_any_instance_of(Die).to receive(:roll).and_return(5)
      @game.play(1)
      expect(@player.health).to eq(@initial_health + 15)
    end

    it "should pass the player with a die roll of 3 or 4" do
      allow_any_instance_of(Die).to receive(:roll).and_return(3)
      @game.play(1)
      expect(@player.health).to eq(@initial_health)
    end

    it "should blam the player with a die roll of 1 or 2" do
      allow_any_instance_of(Die).to receive(:roll).and_return(1)
      @game.play(1)
      expect(@player.health).to eq(@initial_health - 10)
    end

    it "should execute as many rounds as specified in the rounds paramenter in the play method" do
      rounds = 4
      allow_any_instance_of(Die).to receive(:roll).and_return(1)
      @game.play(rounds)
      expect(@player.health).to eq(@initial_health -10 * rounds)
    end

    it "assigns a treasure for points during a player's turn" do
      game = Game.new("Knuckleheads")
      player = Player.new("moe")
      game.add_player(player)
      game.play(1)
      expect(player.points).not_to be_zero
    end



    it "computes total points as the sum of all player points" do
      game = Game.new("Knuckleheads")

      player1 = Player.new("moe")
      player2 = Player.new("larry")

      game.add_player(player1)
      game.add_player(player2)

      player1.found_treasure(Treasure.new(:hammer, 50))
      player1.found_treasure(Treasure.new(:hammer, 50))
      player2.found_treasure(Treasure.new(:crowbar, 400))

      expect(game.total_points).to eq(500)
    end

  end
end
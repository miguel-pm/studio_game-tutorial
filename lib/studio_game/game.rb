require_relative 'game_turn'
require_relative 'treasure_trove'
require_relative 'player'

module StudioGame
  class Game
    attr_reader :title
    def initialize(title)
      @title = title
      @players = []
    end

    def load_players(file_name)
      File.readlines(file_name).each do |line|
        name, health = line.split(",")
        add_player(Player.new(name, Integer(health)))
      end
    end

    def save_high_scores(file_name="high_scores.txt")
      File.open(file_name, "w") do |file|
        file.puts "#{@title} High Scores:"
        @players.sort.each do |player|
          file.puts high_score_entry(player)
        end
      end
    end

    def high_score_entry(player)
      "#{player.name.ljust(20, '.')} #{player.score}"
    end

    def add_player(player)
      @players << player
    end

    def total_points
      @players.reduce(0) { |sum, player| sum + player.points }
    end

    def print_stats
      strong, wimpy = @players.partition { |player| player.strong? }
      sorted_players = @players.sort
      puts "\n#{@title} statistics:"
      @players.each do |player|
        puts "\n#{player.name}'s points total:"
        player.each_found_treasure do |treasure|
          puts "#{treasure.points} total #{treasure.name} points"
        end
        puts "#{player.points} grand total points"
      end
      puts "\n#{strong.length} Strong players:"
      strong.each do |player|
        puts "#{player.name} (#{player.health})"
      end
      puts "\n#{wimpy.length} Wimpy players:"
      wimpy.each do |player|
        puts "#{player.name} (#{player.health})"
      end
      puts "\n#{@title} high scores:"
      sorted_players.each do |player|
        puts high_score_entry(player)
      end
      puts "#{total_points} total points from treasures found"
    end

    def play(rounds)
      treasures = TreasureTrove::TREASURES
      puts "There are #{treasures.size} treasures in the game:"
      treasures.each do |treasure|
        puts "#{treasure.name.to_s.ljust(20, '.')} #{treasure.points}"
      end
      puts "There are #{@players.size} players in #{@title}:"
      puts @players
      1.upto(rounds) do |index|
        puts "\nRound #{index}:"
        @players.each do |player|
          GameTurn.take_turn(player)
        end
      end
    end
  end
end
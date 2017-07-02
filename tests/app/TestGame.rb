require "minitest/autorun"
require "./app/Board.rb"
require "./app/Game.rb"

class TestGame < MiniTest::Test

	def setUp
		@board = Board.new
		@game = Game.new
	end

	def test_that_winner_string_gets_outputed_if_game_has_winner
		assert_equal "ab", "a"
	end

	def test_get_winner

	end

end
#require './db/MySQL'
require './app/Player.rb'
require './app/Board.rb'
require './app/Game.rb'

game = Game.new

game.start()
game.end()
class Game

	attr_accessor :humanPlayer, 
				:digitalPlayer, 
				:board, 
				:nextPlayer,
				:lastPlayer,
				:lastMove,
				:nextMove

	########################################################

	def initialize()
		setPlayers()
		playersToString()
		setBoard()
		setPlayerToStart()
		playerToStartToString()
		
	end

	########################################################

	def setBoard
		@board = Board.new
	end 

	########################################################

	def setPlayers
		@humanPlayer = Player.new(1, 'joe')
		@digitalPlayer = Player.new(2)
	end

	########################################################

	def playersToString
		@humanPlayer.toString
		@digitalPlayer.toString
	end

	########################################################

	def printBoard
		@board.printMatrix
	end

	########################################################

	def start
		puts 'Game started ...'

		while ( @board.hasSpotsAvailable() )

			printBoard()

			if hasWinner()
				puts 'Player ', @getWinner, ' WINS !!!'
				pri
				break
			end 
			
			showSpotsAvailable()
			@nextMove = getNextMove()
			if moveIsValid()
				updateBoard()
				toggleNextPlayer()
			end
		end
	end

	########################################################

	def end
		puts 'Game ended ...'
	end

	########################################################

	def getNextMove

		if nextPlayerIsPc()
			return @board.getRandomAvailableSpot()
		end

		puts "player ", @nextPlayer, "move: "
		print "> "
		return gets.chomp
	end

	########################################################

	def nextPlayerIsPc
		return @nextPlayer == "2"
	end

	########################################################

	def updateBoard
		@lastMove = @nextMove
		@board.addMove(@lastMove, @nextPlayer)
	end

	########################################################

	def moveIsValid
		spotsAvailable = @board.spotsAvailable
		return spotsAvailable.include? (@nextMove.to_s)
	end

	########################################################

	def showSpotsAvailable
		spotsAvailable = @board.spotsAvailable
		print "spots available: "
		puts spotsAvailable.join(", ")
	end 

	########################################################

	def setPlayerToStart
		@nextPlayer = rand(1..2)
	end

	########################################################
	
	def toggleNextPlayer

		if @nextPlayer == "1"
			@nextPlayer = "2"

		else
			@nextPlayer = "1"
		end
	
	end

	########################################################
	
	def playerToStartToString
		puts "Player to start: ", @nextPlayer
	end

	########################################################

	def hasWinner
		return @board.hasVerticalSequence() ||
			@board.hasHorizontalSequence() ||
			@board.hasDiagonalSequence()
	end

	########################################################

	def getWinner
		return @board.winningSequence
	end

end